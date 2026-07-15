#!/usr/bin/env -S uv run
# /// script
# dependencies = ["pillow>=11,<12"]
# ///

import argparse
import json
from pathlib import Path

from PIL import Image, ImageChops, ImageStat


def resolve_box(values: list[float], size: tuple[int, int]) -> tuple[int, int, int, int]:
    if len(values) != 4 or any(not 0.0 <= float(value) <= 1.0 for value in values):
        raise ValueError(f"invalid normalized box: {values}")
    width, height = size
    box = (
        round(float(values[0]) * width),
        round(float(values[1]) * height),
        round(float(values[2]) * width),
        round(float(values[3]) * height),
    )
    if box[0] >= box[2] or box[1] >= box[3]:
        raise ValueError(f"empty normalized box: {values}")
    return box


def image_metrics(image: Image.Image) -> dict:
    rgb = image.convert("RGB")
    stat = ImageStat.Stat(rgb)
    mean_rgb = stat.mean
    luma_stat = ImageStat.Stat(rgb.convert("L"))
    mean_luma = luma_stat.mean[0]
    stddev_luma = luma_stat.stddev[0]
    dark = sum(1 for red, green, blue in rgb.getdata() if max(red, green, blue) <= 8)
    total = rgb.width * rgb.height
    return {
        "mean_rgb": [round(value, 3) for value in mean_rgb],
        "mean_luma": round(mean_luma, 3),
        "stddev_luma": round(stddev_luma, 3),
        "dark_fraction": round(dark / total, 6) if total else 1.0,
    }


def check_minimums(name: str, metrics: dict, rules: dict) -> list[str]:
    failures = []
    if metrics["mean_luma"] < float(rules.get("min_mean_luma", 0.0)):
        failures.append(f"{name}: mean_luma below minimum")
    if metrics["stddev_luma"] < float(rules.get("min_stddev_luma", 0.0)):
        failures.append(f"{name}: stddev_luma below minimum")
    if metrics["dark_fraction"] > float(rules.get("max_dark_fraction", 1.0)):
        failures.append(f"{name}: dark_fraction above maximum")
    minimum_rgb = rules.get("min_mean_rgb", [0.0, 0.0, 0.0])
    maximum_rgb = rules.get("max_mean_rgb", [255.0, 255.0, 255.0])
    for index, channel in enumerate("rgb"):
        if metrics["mean_rgb"][index] < float(minimum_rgb[index]):
            failures.append(f"{name}: mean_{channel} below minimum")
        if metrics["mean_rgb"][index] > float(maximum_rgb[index]):
            failures.append(f"{name}: mean_{channel} above maximum")
    green_excess = float(rules.get("min_green_excess", -255.0))
    if metrics["mean_rgb"][1] - max(metrics["mean_rgb"][0], metrics["mean_rgb"][2]) < green_excess:
        failures.append(f"{name}: green excess below minimum")
    return failures


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("screenshot", type=Path)
    parser.add_argument("--profile", type=Path, required=True)
    parser.add_argument("--report", type=Path, required=True)
    parser.add_argument("--previous", type=Path)
    args = parser.parse_args()

    profile = json.loads(args.profile.read_text())
    image = Image.open(args.screenshot).convert("RGB")
    content_box = resolve_box(profile["content_box_normalized"], image.size)
    content_metrics = image_metrics(image.crop(content_box))
    failures = check_minimums("content", content_metrics, profile)
    content_delta_rms = None
    if args.previous:
        previous = Image.open(args.previous).convert("RGB")
        if previous.size != image.size:
            failures.append(f"previous frame size {previous.size} differs from current frame size {image.size}")
        else:
            delta = ImageChops.difference(image.crop(content_box), previous.crop(content_box))
            rms = ImageStat.Stat(delta).rms
            content_delta_rms = round((sum(value * value for value in rms) / 3.0) ** 0.5, 6)
            if content_delta_rms < float(profile.get("min_content_delta_rms", 0.0)):
                failures.append("content did not change between captures")

    regions = []
    for rules in profile.get("regions", []):
        box = resolve_box(rules["box_normalized"], image.size)
        metrics = image_metrics(image.crop(box))
        region_failures = check_minimums(rules["name"], metrics, rules)
        failures.extend(region_failures)
        regions.append({"name": rules["name"], "box": list(box), **metrics, "failures": region_failures})

    report = {
        "screenshot": str(args.screenshot.resolve()),
        "profile": str(args.profile.resolve()),
        "size": list(image.size),
        "content_box": list(content_box),
        "content": content_metrics,
        "previous": str(args.previous.resolve()) if args.previous else None,
        "content_delta_rms": content_delta_rms,
        "regions": regions,
        "status": "fail" if failures else "pass",
        "failures": failures,
    }
    args.report.parent.mkdir(parents=True, exist_ok=True)
    args.report.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))
    return 1 if failures else 0


if __name__ == "__main__":
    raise SystemExit(main())
