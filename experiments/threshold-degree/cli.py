from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Sequence

from solver import BooleanDomain, find_threshold_degree


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=(
            "Compute the threshold degree of a total or partial Boolean function "
            "with linear programming."
        )
    )
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument(
        "--truth-table",
        help=(
            "Full truth-table bitstring in lexicographic input order, for example "
            "0110 for two-bit XOR."
        ),
    )
    source.add_argument(
        "--input",
        type=Path,
        help="JSON file containing a truth_table or a list of partial-domain points.",
    )
    parser.add_argument(
        "--n",
        type=int,
        default=None,
        help="Optional number of input bits used to validate either input form.",
    )
    parser.add_argument(
        "--max-degree",
        type=int,
        default=None,
        help="Stop after this degree and return only a lower bound if still infeasible.",
    )
    parser.add_argument(
        "--no-dual",
        action="store_true",
        help="Skip the dual lower-bound certificate.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Optional path for the result JSON.",
    )
    return parser


def load_domain(path: Path, expected_n_bits: int | None = None) -> BooleanDomain:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(payload, dict):
        raise ValueError("the input JSON must contain an object")

    declared_n_bits = payload.get("n_bits")
    if (
        expected_n_bits is not None
        and declared_n_bits is not None
        and expected_n_bits != declared_n_bits
    ):
        raise ValueError(
            f"--n declares {expected_n_bits} bits, but the JSON declares "
            f"{declared_n_bits}"
        )
    n_bits = expected_n_bits if expected_n_bits is not None else declared_n_bits
    if "truth_table" in payload:
        return BooleanDomain.from_truth_table(payload["truth_table"], n_bits=n_bits)
    if "points" not in payload:
        raise ValueError("the input JSON must contain truth_table or points")

    points = payload["points"]
    if not isinstance(points, list) or not points:
        raise ValueError("points must be a nonempty list")
    inputs = []
    outputs = []
    for index, point in enumerate(points):
        if not isinstance(point, dict) or "input" not in point or "output" not in point:
            raise ValueError(f"point {index} must contain input and output")
        inputs.append(_parse_input_point(point["input"], index))
        outputs.append(point["output"])

    domain = BooleanDomain.from_points(inputs, outputs)
    if n_bits is not None and domain.n_bits != n_bits:
        raise ValueError(
            f"the points have {domain.n_bits} coordinates, not the declared {n_bits}"
        )
    return domain


def _parse_input_point(value: str | Sequence[int | float], index: int) -> list[int | float]:
    if isinstance(value, str):
        if not value or any(bit not in "01" for bit in value):
            raise ValueError(f"point {index} input must be a nonempty 0/1 bitstring")
        return [int(bit) for bit in value]
    if isinstance(value, Sequence):
        return list(value)
    raise ValueError(f"point {index} input must be a bitstring or list")


def main() -> None:
    args = build_parser().parse_args()
    if args.truth_table is not None:
        domain = BooleanDomain.from_truth_table(args.truth_table, n_bits=args.n)
    else:
        domain = load_domain(args.input, expected_n_bits=args.n)

    result = find_threshold_degree(
        domain,
        max_degree=args.max_degree,
        compute_dual=not args.no_dual,
    )
    text = json.dumps(result.to_dict(), indent=2)
    if args.output is not None:
        args.output.write_text(text + "\n", encoding="utf-8")
    print(text)


if __name__ == "__main__":
    main()
