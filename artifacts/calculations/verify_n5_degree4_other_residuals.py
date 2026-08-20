#!/usr/bin/env python3
"""Verify finite exact H4 coverage for residual degree-four families."""

from __future__ import annotations

import argparse
from pathlib import Path

import numpy as np

import screen_n5_degree4_cocircuit_families as families
import search_n5_degree4_family_shattering as shattering
from search_n5_degree4_other_residuals import DEFAULT_ORBITS, archive_path


VERTICES = 32


def masks_from_signs(signs: np.ndarray) -> np.ndarray:
    powers = np.array([1 << vertex for vertex in range(VERTICES)], dtype=np.uint64)
    return ((signs > 0).astype(np.uint64) @ powers).astype(np.uint32)


def verify_archive(path: Path, expected_orbit: int | None = None) -> None:
    with np.load(path, allow_pickle=False) as archive:
        orbit = int(archive["orbit"])
        normal = tuple(int(value) for value in archive["normal"])
        masks = archive["masks"]
        denominators = archive["denominators"]
        witnesses = archive["witness_indices"]
        coefficients = archive["score_coefficients"]

    if expected_orbit is not None:
        assert orbit == expected_orbit
    normals = families.orbit_normals()
    assert normal == normals[orbit]
    signs = families.extension_signs(normal)
    assert masks.dtype == np.uint32
    assert np.array_equal(masks, masks_from_signs(signs))
    assert witnesses.dtype == np.int16
    assert coefficients.dtype == np.int64
    assert coefficients.shape == (len(signs), 25)
    assert witnesses.shape == (len(signs),)
    assert np.all(witnesses >= 0)
    assert np.all(witnesses < len(denominators))

    for denominators_index, current in enumerate(denominators):
        assert shattering.valid_denominators(current)
        selected = np.flatnonzero(witnesses == denominators_index)
        if not len(selected):
            continue
        matrix = shattering.cleared_matrix(current)
        for start in range(0, len(selected), 256):
            batch = selected[start : start + 256]
            values = matrix @ coefficients[batch].astype(object).T
            signed = signs[batch].astype(object).T * values
            assert np.all(signed > 0)
    print(
        f"orbit {orbit}: verified {len(signs)} exact H4 certificates "
        f"using {len(denominators)} denominator tuples",
        flush=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--orbit", type=int, action="append", choices=DEFAULT_ORBITS)
    arguments = parser.parse_args()
    orbits = arguments.orbit or list(DEFAULT_ORBITS)
    for orbit in orbits:
        verify_archive(archive_path(orbit), orbit)


if __name__ == "__main__":
    main()
