import argparse
import re
from pathlib import Path


def function_body(source: str, entry: str) -> tuple[int, int]:
    match = re.search(rf"\bfn\s+{re.escape(entry)}\s*\(", source)
    if match is None:
        raise ValueError(f"entry point not found: {entry}")
    start = source.find("{", match.end())
    if start < 0:
        raise ValueError(f"entry point has no body: {entry}")
    depth = 0
    for index in range(start, len(source)):
        if source[index] == "{":
            depth += 1
        elif source[index] == "}":
            depth -= 1
            if depth == 0:
                return start + 1, index
    raise ValueError(f"unterminated entry point body: {entry}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--entry", required=True)
    parser.add_argument("--body", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    source = args.input.read_text()
    body = args.body.read_text().strip()
    start, end = function_body(source, args.entry)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(f"{source[:start]}\n{body}\n{source[end:]}")


if __name__ == "__main__":
    main()
