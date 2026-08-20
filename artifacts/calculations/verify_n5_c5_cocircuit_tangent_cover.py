#!/usr/bin/env python3
"""Verify an exact clause cover of closed-C5 cocircuit tangent assignments."""

from __future__ import annotations

import argparse
from collections import Counter
import json
from pathlib import Path

import numpy as np

import classify_n5_c5_cocircuit_tangent_topes as cover
import screen_n5_c5_two_scale as c5
import survey_n5_c5_locked_cells as survey


def verify_wrong_vector(vector: tuple[int, ...]) -> tuple[int, int]:
    assert len(vector) == 16
    values = cover.FOURIER @ np.array(vector, dtype=np.int64)
    positive, negative = cover.sign_clause(values)
    assert positive | negative
    assert any(
        int(c5.EDGE_SIGNS[edge_index]) * vector[6 + edge_index] < 0
        for edge_index in range(10)
    )
    return positive, negative


def verify_gordan_record(record: dict[str, object]) -> tuple[int, int]:
    positive = int(record["positive_mask"])
    negative = int(record["negative_mask"])
    weights = tuple(int(value) for value in record["weights"])
    assert len(weights) == 42
    assert positive & negative == 0
    assert all(weight >= 0 for weight in weights) and any(weights)
    total = np.zeros(16, dtype=object)
    for vertex, weight in enumerate(weights[:32]):
        if not weight:
            continue
        bit = 1 << vertex
        assert bool(positive & bit) != bool(negative & bit)
        sign = 1 if positive & bit else -1
        total += weight * sign * cover.FOURIER[vertex].astype(object)
    for edge_index, weight in enumerate(weights[32:]):
        if weight:
            total += weight * cover.EDGE_ROWS[edge_index].astype(object)
    assert np.all(total == 0)
    return positive, negative


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument(
        "--allow-prefix",
        action="store_true",
        help="verify a resumable zero-set prefix instead of requiring all rays",
    )
    arguments = parser.parse_args()
    payload = json.loads(arguments.input.read_text())

    wrong_clauses = {
        verify_wrong_vector(tuple(int(value) for value in vector))
        for vector in payload["wrong_edge_vectors"]
    }
    assert len(wrong_clauses) == len(payload["wrong_edge_vectors"])
    gordan_clauses = {
        verify_gordan_record(record) for record in payload["gordan_circuits"]
    }
    assert len(gordan_clauses) == len(payload["gordan_circuits"])

    archive = cover.known_raw_masks()
    assert len({survey.canonical_mask(mask) for mask in archive}) == 380
    rays = cover.load_rays()
    rays.sort(key=lambda ray: (int(np.sum(cover.FOURIER @ np.array(ray) == 0)), ray))
    processed = [
        ray for ray in rays
        if int(np.sum(cover.FOURIER @ np.array(ray, dtype=np.int64) == 0))
        <= int(payload["max_zero_size"])
    ]
    assert len(processed) == int(payload["processed_ray_count"])
    if not arguments.allow_prefix:
        assert len(rays) == len(processed) == 2_272
        assert len(wrong_clauses) == 5_837
        assert len(gordan_clauses) == 892

    sizes: Counter[int] = Counter()
    for ray_index, ray in enumerate(processed):
        ray_values = cover.FOURIER @ np.array(ray, dtype=np.int64)
        zero_vertices = tuple(int(vertex) for vertex in np.flatnonzero(ray_values == 0))
        fixed_positive = sum(
            (int(value) > 0) << vertex
            for vertex, value in enumerate(ray_values)
            if value
        )
        fixed_negative = sum(
            (int(value) < 0) << vertex
            for vertex, value in enumerate(ray_values)
            if value
        )
        covered = np.zeros(1 << len(zero_vertices), dtype=bool)

        forcing = cover.exact_simple_forcing(ray, zero_vertices)
        if forcing is None:
            covered[:] = True
        else:
            view = covered.reshape((2,) * len(zero_vertices))
            for position, required in forcing.items():
                selector: list[object] = [slice(None)] * len(zero_vertices)
                selector[len(zero_vertices) - 1 - position] = int(not required)
                view[tuple(selector)] = True

        for clause in wrong_clauses:
            cover.apply_local_clause(
                covered, zero_vertices, fixed_positive, fixed_negative, *clause
            )
        for clause in gordan_clauses:
            cover.apply_local_clause(
                covered, zero_vertices, fixed_positive, fixed_negative, *clause
            )
        for mask in archive:
            if (mask & fixed_positive) != fixed_positive:
                continue
            if ((~mask) & fixed_negative) != fixed_negative:
                continue
            local = sum(
                ((mask >> vertex) & 1) << position
                for position, vertex in enumerate(zero_vertices)
            )
            covered[local] = True

        assert np.all(covered), f"uncovered tangent assignment at ray {ray_index}"
        sizes[len(zero_vertices)] += 1
        if (ray_index + 1) % 250 == 0:
            print(f"exact ray cubes covered: {ray_index + 1}")

    print(f"wrong-edge clauses: {len(wrong_clauses)}")
    print(f"Gordan clauses: {len(gordan_clauses)}")
    print(f"covered ray zero-set sizes: {dict(sorted(sizes.items()))}")
    if arguments.allow_prefix:
        print("verified exact cocircuit tangent prefix cover")
    else:
        print("verified exact cocircuit tangent clause cover")


if __name__ == "__main__":
    main()
