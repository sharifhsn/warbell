#!/usr/bin/env -S uv run --script
# /// script
# dependencies = ["zstandard"]
# ///

import argparse
import hashlib
import json
import math
import struct
from pathlib import Path

import zstandard


IDENTIFIER = b"\xabKTX 20\xbb\r\n\x1a\n"
RGBA16_FLOAT = 97
RGB9E5_UFLOAT = 123


def rgb9e5(value: int) -> tuple[float, float, float, float]:
    exponent = value >> 27
    scale = math.ldexp(1.0, exponent - 24)
    return (
        (value & 0x1FF) * scale,
        ((value >> 9) & 0x1FF) * scale,
        ((value >> 18) & 0x1FF) * scale,
        1.0,
    )


def texel(data: bytes, format_: int, index: int) -> tuple[float, float, float, float]:
    if format_ == RGBA16_FLOAT:
        return struct.unpack_from("<4e", data, index * 8)
    if format_ == RGB9E5_UFLOAT:
        return rgb9e5(struct.unpack_from("<I", data, index * 4)[0])
    raise ValueError(f"unsupported VkFormat {format_}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument("--extract", type=Path)
    args = parser.parse_args()

    source = args.input.read_bytes()
    if source[:12] != IDENTIFIER:
        raise ValueError("not a KTX2 file")
    fields = struct.unpack_from("<9I4I2Q", source, 12)
    format_, type_size, width, height, depth, layers, faces, levels, compression = fields[:9]
    if levels != 1 or layers not in (0, 1) or faces != 1:
        raise ValueError("only single-level non-array 3D LUTs are supported")
    level_offset, level_length, raw_length = struct.unpack_from("<3Q", source, 80)
    payload = source[level_offset : level_offset + level_length]
    if compression == 2:
        payload = zstandard.ZstdDecompressor().decompress(payload, max_output_size=raw_length)
    elif compression != 0:
        raise ValueError(f"unsupported supercompression scheme {compression}")
    if len(payload) != raw_length:
        raise ValueError(f"decoded {len(payload)} bytes, expected {raw_length}")
    bytes_per_texel = 8 if format_ == RGBA16_FLOAT else 4 if format_ == RGB9E5_UFLOAT else 0
    if len(payload) != width * height * depth * bytes_per_texel:
        raise ValueError("decoded level size does not match dimensions and format")

    samples = {}
    for name, xyz in {
        "origin": (0, 0, 0),
        "center": (width // 2, height // 2, depth // 2),
        "last": (width - 1, height - 1, depth - 1),
        "red": (width - 1, 0, 0),
        "green": (0, height - 1, 0),
        "blue": (0, 0, depth - 1),
    }.items():
        x, y, z = xyz
        value = texel(payload, format_, (z * height + y) * width + x)
        samples[name] = {"coord": xyz, "rgba": [round(component, 7) for component in value]}
    report = {
        "path": str(args.input),
        "vk_format": format_,
        "type_size": type_size,
        "size": [width, height, depth],
        "supercompression": compression,
        "encoded_sha256": hashlib.sha256(source).hexdigest(),
        "decoded_sha256": hashlib.sha256(payload).hexdigest(),
        "decoded_size": len(payload),
        "samples": samples,
    }
    print(json.dumps(report, indent=2))
    if args.extract:
        args.extract.write_bytes(payload)


if __name__ == "__main__":
    main()
