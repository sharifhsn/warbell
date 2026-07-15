#!/usr/bin/env -S uv run
# /// script
# dependencies = ["pillow>=11,<12"]
# ///

import argparse
import json
import math
from pathlib import Path

from PIL import Image, ImageChops, ImageStat


def resolve_box(region: dict, size: tuple[int, int]) -> tuple[int, int, int, int]:
    if "box_normalized" in region:
        values = region["box_normalized"]
        if len(values) != 4 or any(not 0.0 <= float(value) <= 1.0 for value in values):
            raise SystemExit(f"invalid normalized region {region['name']}: {values}")
        width, height = size
        box = (
            round(float(values[0]) * width),
            round(float(values[1]) * height),
            round(float(values[2]) * width),
            round(float(values[3]) * height),
        )
    else:
        box = tuple(int(value) for value in region["box"])
    if len(box) != 4 or box[0] < 0 or box[1] < 0 or box[2] > size[0] or box[3] > size[1]:
        raise SystemExit(f"out-of-bounds region {region['name']}: {box} for {size}")
    if box[0] >= box[2] or box[1] >= box[3]:
        raise SystemExit(f"empty region {region['name']}: {box}")
    return box


def region_metrics(actual: Image.Image, golden: Image.Image, box: tuple[int, int, int, int]):
    actual_region = actual.crop(box).convert("RGB")
    golden_region = golden.crop(box).convert("RGB")
    diff = ImageChops.difference(actual_region, golden_region)
    stat = ImageStat.Stat(diff)
    rms = math.sqrt(sum(value * value for value in stat.rms) / 3)
    changed = sum(1 for pixel in diff.getdata() if pixel != (0, 0, 0))
    total = actual_region.width * actual_region.height
    return {
        "rms": round(rms, 3),
        "changed_fraction": round(changed / total, 6) if total else 0.0,
        "actual_mean_rgb": [round(value, 2) for value in ImageStat.Stat(actual_region).mean],
        "golden_mean_rgb": [round(value, 2) for value in ImageStat.Stat(golden_region).mean],
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("actual", type=Path)
    parser.add_argument("golden", type=Path)
    parser.add_argument("--regions", type=Path)
    parser.add_argument("--rms-threshold", type=float, default=8.0)
    parser.add_argument("--report", type=Path)
    args = parser.parse_args()

    actual = Image.open(args.actual)
    golden = Image.open(args.golden)
    if actual.size != golden.size:
        raise SystemExit(f"image size mismatch: actual={actual.size} golden={golden.size}")

    regions = [{"name": "frame", "box": [0, 0, actual.width, actual.height]}]
    if args.regions:
        regions = json.loads(args.regions.read_text())["regions"]

    results = []
    failed = False
    for region in regions:
        box = resolve_box(region, actual.size)
        metrics = region_metrics(actual, golden, box)
        threshold = float(region.get("rms_threshold", args.rms_threshold))
        status = "pass" if metrics["rms"] <= threshold else "fail"
        failed |= status == "fail"
        results.append({"name": region["name"], "box": list(box), "status": status, "threshold": threshold, **metrics})

    report = {
        "actual": str(args.actual.resolve()),
        "golden": str(args.golden.resolve()),
        "size": list(actual.size),
        "status": "fail" if failed else "pass",
        "regions": results,
    }
    output = json.dumps(report, indent=2)
    if args.report:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        args.report.write_text(output + "\n")
    print(output)
    return 1 if failed else 0


if __name__ == "__main__":
    raise SystemExit(main())
