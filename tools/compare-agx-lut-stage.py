#!/usr/bin/env -S uv run --script
# /// script
# dependencies = ["numpy", "pillow", "zstandard"]
# ///

import argparse
import json
import struct
from pathlib import Path

import numpy as np
import zstandard
from PIL import Image


def read_rgba16_lut(path: Path) -> np.ndarray:
    source = path.read_bytes()
    if source[:12] != b"\xabKTX 20\xbb\r\n\x1a\n":
        raise ValueError("not a KTX2 file")
    format_, _, width, height, depth, layers, faces, levels, compression = struct.unpack_from(
        "<9I", source, 12
    )
    if format_ != 97 or layers not in (0, 1) or faces != 1 or levels != 1:
        raise ValueError("expected a single-level R16G16B16A16_SFLOAT 3D LUT")
    offset, length, raw_length = struct.unpack_from("<3Q", source, 80)
    payload = source[offset : offset + length]
    if compression == 2:
        payload = zstandard.ZstdDecompressor().decompress(payload, max_output_size=raw_length)
    elif compression != 0:
        raise ValueError(f"unsupported supercompression scheme {compression}")
    return np.frombuffer(payload, dtype="<f2").astype(np.float32).reshape(depth, height, width, 4)


def sample_trilinear(lut: np.ndarray, coordinates: np.ndarray) -> np.ndarray:
    size = np.array(lut.shape[2::-1], dtype=np.float32)
    position = np.clip(coordinates, 0.0, 1.0) * (size - 1.0)
    low = np.floor(position).astype(np.int32)
    high = np.minimum(low + 1, size.astype(np.int32) - 1)
    weight = position - low
    x0, y0, z0 = low[..., 0], low[..., 1], low[..., 2]
    x1, y1, z1 = high[..., 0], high[..., 1], high[..., 2]
    wx, wy, wz = weight[..., 0:1], weight[..., 1:2], weight[..., 2:3]
    c00 = lut[z0, y0, x0, :3] * (1.0 - wx) + lut[z0, y0, x1, :3] * wx
    c01 = lut[z0, y1, x0, :3] * (1.0 - wx) + lut[z0, y1, x1, :3] * wx
    c10 = lut[z1, y0, x0, :3] * (1.0 - wx) + lut[z1, y0, x1, :3] * wx
    c11 = lut[z1, y1, x0, :3] * (1.0 - wx) + lut[z1, y1, x1, :3] * wx
    c0 = c00 * (1.0 - wy) + c01 * wy
    c1 = c10 * (1.0 - wy) + c11 * wy
    return c0 * (1.0 - wz) + c1 * wz


def srgb_to_linear(value: np.ndarray) -> np.ndarray:
    return np.where(value <= 0.04045, value / 12.92, ((value + 0.055) / 1.055) ** 2.4)


def linear_to_srgb(value: np.ndarray) -> np.ndarray:
    value = np.maximum(value, 0.0)
    return np.where(value <= 0.0031308, value * 12.92, 1.055 * value ** (1.0 / 2.4) - 0.055)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("coordinates", type=Path, help="screenshot from the LUT-bypass probe")
    parser.add_argument("actual", type=Path, help="screenshot from the untouched AgX shader")
    parser.add_argument("lut", type=Path)
    parser.add_argument("--prediction", type=Path)
    parser.add_argument("--report", type=Path)
    parser.add_argument("--tolerance", type=float, default=8.0)
    args = parser.parse_args()

    coordinate_srgb = np.asarray(Image.open(args.coordinates).convert("RGB"), dtype=np.float32) / 255.0
    actual = np.asarray(Image.open(args.actual).convert("RGB"), dtype=np.float32)
    if coordinate_srgb.shape != actual.shape:
        raise ValueError("screenshots have different dimensions")
    coordinates = srgb_to_linear(np.clip(coordinate_srgb, 0.0, 1.0))
    sampled = sample_trilinear(read_rgba16_lut(args.lut), coordinates)
    prediction = np.clip(linear_to_srgb(sampled) * 255.0, 0.0, 255.0)
    changed = np.max(np.abs(coordinate_srgb * 255.0 - actual), axis=2) > 12.0
    error = np.abs(prediction - actual)
    selected = error[changed]
    report = {
        "coordinate_screenshot": str(args.coordinates),
        "actual_screenshot": str(args.actual),
        "lut": str(args.lut),
        "compared_pixels": int(changed.sum()),
        "mean_absolute_error": float(selected.mean()) if selected.size else 0.0,
        "p95_absolute_error": float(np.percentile(selected, 95)) if selected.size else 0.0,
        "max_absolute_error": float(selected.max()) if selected.size else 0.0,
        "tolerance": args.tolerance,
    }
    report["passed"] = report["p95_absolute_error"] <= args.tolerance
    rendered = json.dumps(report, indent=2)
    print(rendered)
    if args.report:
        args.report.write_text(rendered + "\n")
    if args.prediction:
        Image.fromarray(prediction.astype(np.uint8), "RGB").save(args.prediction)
    raise SystemExit(0 if report["passed"] else 1)


if __name__ == "__main__":
    main()
