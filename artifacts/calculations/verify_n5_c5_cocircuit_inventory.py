#!/usr/bin/env python3
"""Verify the exhaustive closed-C5 quadratic cocircuit inventory.

The C++ enumerator scans all rank-15 fifteen-subsets.  This verifier checks
the emitted primitive rays, their exact zero sets, the order-40 quotient, and
coverage of every extreme ray already found in the 380 known locked cells.
"""

from __future__ import annotations

from collections import Counter
import csv
from functools import reduce
import hashlib
import json
from math import gcd
from pathlib import Path

import numpy as np

import screen_n5_c5_two_scale as c5
import survey_n5_c5_locked_cells as survey
import verify_n5_c5_fixed_chord_extremizer as extremal


DIRECT_PATH = Path(__file__).with_name("n5_c5_all_cocircuit_rays.csv")
ORBIT_PATH = Path(__file__).with_name("n5_c5_cocircuit_ray_orbits.csv")
KNOWN_PATH = Path(__file__).with_name("n5_c5_locked_extreme_ray_incidence.json")
DIRECT_SHA256 = "e9c578c66fa5d1aa806bfae5bc0e3fdbee4b7a7cfb341106cfdb42efb5e0acda"
ORBIT_SHA256 = "0d02ec19595c3512e75da457e6c5d8a4aa89179c24e047ae838cecf4eb63e5ac"
DIRECT_ZERO_DISTRIBUTION = {
    15: 56_840,
    16: 16_470,
    17: 9_260,
    18: 2_570,
    19: 820,
    20: 957,
    22: 110,
    24: 115,
}
ORBIT_ZERO_DISTRIBUTION = {
    15: 1_466,
    16: 428,
    17: 240,
    18: 73,
    19: 22,
    20: 33,
    22: 4,
    24: 6,
}


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_rays(path: Path) -> list[tuple[int, ...]]:
    with path.open(newline="") as stream:
        rows = list(csv.reader(stream))
    assert rows[0] == [
        "c0", "c1", "c2", "c3", "c4", "c5",
        "c01", "c02", "c03", "c04", "c12",
        "c13", "c14", "c23", "c24", "c34",
    ]
    return [tuple(int(value) for value in row) for row in rows[1:]]


EDGE_INDEX = {edge: index for index, edge in enumerate(c5.EDGES)}


def transform(
    ray: tuple[int, ...],
    permutation: tuple[int, ...],
    output_complement: bool,
    input_complement: bool,
) -> tuple[int, ...]:
    answer = [0] * 16
    output_sign = -1 if output_complement else 1
    input_sign = -1 if input_complement else 1
    answer[0] = output_sign * ray[0]
    for source in range(5):
        answer[1 + permutation[source]] = (
            output_sign * input_sign * ray[1 + source]
        )
    for source_index, (first, second) in enumerate(c5.EDGES):
        image = tuple(sorted((permutation[first], permutation[second])))
        answer[6 + EDGE_INDEX[image]] = output_sign * ray[6 + source_index]
    return tuple(answer)


def orbit(ray: tuple[int, ...]) -> set[tuple[int, ...]]:
    return {
        transform(ray, permutation, exchanges_colors, input_complement)
        for permutation, exchanges_colors in survey.fixed_orthant_symmetries()
        for input_complement in (False, True)
    }


def orbit_key(ray: tuple[int, ...]) -> tuple[int, ...]:
    return min(orbit(ray))


def verify_ray(ray: tuple[int, ...]) -> int:
    assert reduce(gcd, (abs(value) for value in ray if value)) == 1
    for edge_index, edge_sign in enumerate(c5.EDGE_SIGNS.astype(np.int64)):
        assert edge_sign * ray[6 + edge_index] >= 0
    assert any(ray[6 + edge_index] for edge_index in range(10))
    values = c5.FOURIER.astype(np.int64) @ np.array(ray, dtype=np.int64)
    zero_rows = c5.FOURIER[values == 0]
    assert len(zero_rows) >= 15
    assert extremal.modular_rank(zero_rows) == 15

    parity = np.array(
        [-1 if bin(vertex).count("1") % 2 else 1 for vertex in range(32)],
        dtype=np.int64,
    )
    circuit = parity * values
    assert np.all(c5.FOURIER.astype(np.int64).T @ circuit == 0)
    return len(zero_rows)


def main() -> None:
    assert digest(DIRECT_PATH) == DIRECT_SHA256
    assert digest(ORBIT_PATH) == ORBIT_SHA256
    direct = load_rays(DIRECT_PATH)
    representatives = load_rays(ORBIT_PATH)
    assert len(direct) == len(set(direct)) == 87_142
    assert len(representatives) == len(set(representatives)) == 2_272

    direct_set = set(direct)
    representative_set = set(representatives)
    assert representative_set <= direct_set
    assert Counter(verify_ray(ray) for ray in representatives) == Counter(
        ORBIT_ZERO_DISTRIBUTION
    )

    remaining = set(direct)
    reconstructed = set()
    while remaining:
        ray = next(iter(remaining))
        images = orbit(ray)
        key = min(images)
        assert key in representative_set
        reconstructed.add(key)
        remaining.difference_update(images)
    assert reconstructed == representative_set

    direct_values = c5.FOURIER.astype(np.int64) @ np.array(direct, dtype=np.int64).T
    assert Counter(np.sum(direct_values == 0, axis=0).tolist()) == Counter(
        DIRECT_ZERO_DISTRIBUTION
    )

    known_payload = json.loads(KNOWN_PATH.read_text())
    known_rays = {tuple(record["ray"]) for record in known_payload["incidence"]}
    assert len(known_rays) == 3_948
    assert known_rays <= direct_set
    known_orbits = {orbit_key(ray) for ray in known_rays}
    assert len(known_orbits) == 747
    assert known_orbits <= representative_set

    print("closed-C5 primitive cocircuit rays: 87142")
    print("closed-C5 cocircuit ray orbits: 2272")
    print("known locked-cell ray orbits: 747")
    print(f"orbit zero-set sizes: {dict(sorted(ORBIT_ZERO_DISTRIBUTION.items()))}")
    print("verified exact self-dual closed-C5 cocircuit inventory")


if __name__ == "__main__":
    main()
