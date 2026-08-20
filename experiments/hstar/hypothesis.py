from __future__ import annotations

import argparse
import json
from pathlib import Path

from .symmetry import canonical_representative, representative_truth_tables
from .truth_tables import all_inputs, flip_coordinate, truth_table_array_to_bitstring


def compare_local_bit_flip_hypothesis(results_path: Path, n_bits: int):
    payload = json.loads(results_path.read_text(encoding="utf-8"))
    h_by_rep = {}
    for item in payload["results"]:
        if item["estimated_h_star"] is not None:
            h_by_rep[item["truth_table"]] = item["estimated_h_star"]

    inputs = all_inputs(n_bits)
    mismatches = []
    for representative in representative_truth_tables(n_bits):
        rep_bits = truth_table_array_to_bitstring(representative)
        if rep_bits not in h_by_rep:
            continue
        h_value = h_by_rep[rep_bits]
        for coordinate in range(n_bits):
            flipped = flip_coordinate(representative, n_bits, coordinate)
            flipped_rep = canonical_representative(flipped, inputs)
            flipped_bits = truth_table_array_to_bitstring(flipped_rep)
            flipped_h = h_by_rep.get(flipped_bits)
            row = {
                "truth_table": rep_bits,
                "coordinate": coordinate,
                "flipped_representative": flipped_bits,
                "h_star": h_value,
                "flipped_h_star": flipped_h,
                "matches": h_value == flipped_h,
            }
            if not row["matches"]:
                mismatches.append(row)

    return {
        "n_bits": n_bits,
        "tested_pairs": len(representative_truth_tables(n_bits)) * n_bits,
        "mismatches": mismatches,
        "mismatch_count": len(mismatches),
    }


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Compare estimated H* values under single-coordinate input flips."
    )
    parser.add_argument("--results", type=Path, required=True, help="Path to a search JSON file.")
    parser.add_argument("--n", type=int, required=True, help="Number of input bits.")
    return parser


def main() -> None:
    args = build_parser().parse_args()
    payload = compare_local_bit_flip_hypothesis(args.results, args.n)
    print(json.dumps(payload, indent=2))


if __name__ == "__main__":
    main()
