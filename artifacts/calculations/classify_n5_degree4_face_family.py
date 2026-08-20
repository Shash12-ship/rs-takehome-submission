#!/usr/bin/env python3
"""Build and verify the exact H4 certificate for the degree-four face family.

Orbit 62 in the affine-cocircuit reduction has a coordinate face on which the
labels are arbitrary and the opposite face is forced to be four-bit parity.
The one extension giving five-bit parity is excluded, leaving 65,535 targets.

The build phase screens those targets against a fixed deterministic dictionary,
then converts every hit to an integral cleared-score certificate.  Screening
is only an accelerator.  Every archived row is checked with integer arithmetic.
The verification phase uses no optimization or floating-point arithmetic.
"""

from __future__ import annotations

import argparse
import math
from pathlib import Path

import numpy as np

import screen_n5_degree4_cocircuit_families as families
import search_n5_degree4_face_residual as residual
import search_uncovered_cubic_n6 as nonlinear


N = 5
HEADS = 4
WIDTH = N + 1
VERTICES = 1 << N
ORBIT = 62
BASE_DICTIONARY_SIZE = 256
SEED = 20260714
GILBERT_ITERATIONS = 160
EXPECTED_TARGETS = (1 << 16) - 1
HERE = Path(__file__).resolve().parent
DEFAULT_ARCHIVE = HERE / "n5_degree4_face_family_certificate.npz"


def masks_from_signs(signs: np.ndarray) -> np.ndarray:
    powers = (np.uint64(1) << np.arange(VERTICES, dtype=np.uint64))[None, :]
    return np.sum((signs > 0).astype(np.uint64) * powers, axis=1)


def exact_certificate(
    signs: np.ndarray, denominators: np.ndarray
) -> tuple[np.ndarray, int] | None:
    record = nonlinear.exact_head_certificate(signs, denominators)
    if record is None:
        return None
    coefficient_values = [int(value) for value in record["score_coefficients"]]
    common = 0
    for value in coefficient_values:
        common = math.gcd(common, abs(value))
    if common > 1:
        coefficient_values = [value // common for value in coefficient_values]
    coefficients = np.array(coefficient_values, dtype=object)
    minimum = int(record["minimum_signed_cleared_score"])
    if common > 1:
        assert minimum % common == 0
        minimum //= common
    return coefficients, minimum


def exact_dictionary_hit(
    signs: np.ndarray,
    dictionary: list[np.ndarray],
    preferred: int | None,
) -> tuple[int, np.ndarray, int] | None:
    order = []
    if preferred is not None:
        order.append(preferred)
    order.extend(
        index for index in range(len(dictionary)) if index != preferred
    )
    large_fallback = None
    for dictionary_index in order:
        certificate = exact_certificate(signs, dictionary[dictionary_index])
        if certificate is None:
            continue
        coefficients, minimum = certificate
        if max(abs(int(value)) for value in coefficients) >= (1 << 63):
            if large_fallback is None:
                large_fallback = (dictionary_index, coefficients, minimum)
            continue
        return dictionary_index, coefficients, minimum
    return large_fallback


def family_data() -> tuple[np.ndarray, list[np.ndarray]]:
    residual.configure_nonlinear_search()
    normal = families.orbit_normals()[ORBIT]
    assert normal == (1, 0, 0, 1, 0, 0)
    signs = families.extension_signs(normal)
    assert signs.shape == (EXPECTED_TARGETS, VERTICES)
    masks = masks_from_signs(signs)
    assert len(np.unique(masks)) == EXPECTED_TARGETS
    dictionary = families.denominator_dictionary(BASE_DICTIONARY_SIZE, SEED)
    dictionary.extend(
        np.array(denominators, dtype=np.int64)
        for denominators in residual.KNOWN_ADDITIONAL_DENOMINATORS
    )
    assert len(dictionary) == (
        BASE_DICTIONARY_SIZE + len(residual.KNOWN_ADDITIONAL_DENOMINATORS)
    )
    return signs, dictionary


def build_archive(path: Path) -> None:
    signs, dictionary = family_data()
    covered, heuristic_witnesses = residual.heuristic_coverage(
        signs, dictionary, GILBERT_ITERATIONS
    )
    print(
        f"heuristic hits: {int(np.sum(covered))}/{EXPECTED_TARGETS}",
        flush=True,
    )

    witness_indices = np.full(EXPECTED_TARGETS, -1, dtype=np.int16)
    score_coefficients = np.zeros(
        (EXPECTED_TARGETS, 1 + HEADS * WIDTH), dtype=np.int64
    )
    big_target_indices = []
    big_score_coefficients = []
    largest_coefficient = 0

    preferred_order = np.concatenate(
        [np.flatnonzero(covered), np.flatnonzero(~covered)]
    )
    for position, target_index_value in enumerate(preferred_order):
        target_index = int(target_index_value)
        preferred = (
            int(heuristic_witnesses[target_index])
            if covered[target_index]
            else None
        )
        hit = exact_dictionary_hit(
            signs[target_index], dictionary, preferred
        )
        if hit is None:
            raise RuntimeError(
                f"dictionary has no exact hit for target {target_index}"
            )
        dictionary_index, coefficients, minimum = hit
        maximum = max(abs(int(value)) for value in coefficients)
        witness_indices[target_index] = dictionary_index
        if maximum < (1 << 63):
            score_coefficients[target_index] = np.array(
                [int(value) for value in coefficients], dtype=np.int64
            )
        else:
            big_target_indices.append(target_index)
            big_score_coefficients.append(
                [str(int(value)) for value in coefficients]
            )
        assert minimum > 0
        largest_coefficient = max(largest_coefficient, maximum)
        if (position + 1) % 4096 == 0 or position + 1 == EXPECTED_TARGETS:
            print(
                f"exactified {position + 1}/{EXPECTED_TARGETS}; "
                f"largest coefficient bits={largest_coefficient.bit_length()}",
                flush=True,
            )

    denominator_array = np.stack(dictionary).astype(np.int64)
    maximum_big_length = max(
        (
            len(value)
            for row in big_score_coefficients
            for value in row
        ),
        default=1,
    )
    big_string_array = np.array(
        big_score_coefficients,
        dtype=f"<U{maximum_big_length}",
    ).reshape((-1, 1 + HEADS * WIDTH))
    np.savez_compressed(
        path,
        orbit=np.array([ORBIT], dtype=np.int16),
        normal=np.array([1, 0, 0, 1, 0, 0], dtype=np.int16),
        masks=masks_from_signs(signs).astype(np.uint32),
        denominators=denominator_array,
        witness_indices=witness_indices,
        score_coefficients=score_coefficients,
        big_target_indices=np.array(big_target_indices, dtype=np.int32),
        big_score_coefficients=big_string_array,
    )
    print(f"wrote {path}", flush=True)
    verify_archive(path)


def cleared_matrix(denominators: np.ndarray) -> np.ndarray:
    affine = families.core.affine_matrix(N).astype(object)
    values = affine @ denominators.astype(object).T
    full_product = np.prod(values, axis=1)
    columns = [full_product]
    for head in range(HEADS):
        other_product = np.prod(np.delete(values, head, axis=1), axis=1)
        columns.extend(
            affine[:, coordinate] * other_product
            for coordinate in range(WIDTH)
        )
    return np.column_stack(columns).astype(object)


def signs_from_masks(masks: np.ndarray) -> np.ndarray:
    shifts = np.arange(VERTICES, dtype=np.uint64)[None, :]
    positive = ((masks.astype(np.uint64)[:, None] >> shifts) & 1) != 0
    return np.where(positive, 1, -1).astype(np.int8)


def verify_archive(path: Path) -> None:
    archive = np.load(path, allow_pickle=False)
    assert archive["orbit"].tolist() == [ORBIT]
    assert archive["normal"].tolist() == [1, 0, 0, 1, 0, 0]
    masks = archive["masks"]
    denominators = archive["denominators"]
    witness_indices = archive["witness_indices"]
    coefficients = archive["score_coefficients"]
    big_target_indices = archive["big_target_indices"]
    big_coefficients = archive["big_score_coefficients"]
    assert masks.shape == (EXPECTED_TARGETS,)
    dictionary_size = (
        BASE_DICTIONARY_SIZE + len(residual.KNOWN_ADDITIONAL_DENOMINATORS)
    )
    assert denominators.shape == (dictionary_size, HEADS, WIDTH)
    assert witness_indices.shape == (EXPECTED_TARGETS,)
    assert coefficients.shape == (EXPECTED_TARGETS, 1 + HEADS * WIDTH)
    assert big_coefficients.shape == (
        len(big_target_indices),
        1 + HEADS * WIDTH,
    )
    assert np.all((0 <= witness_indices) & (witness_indices < dictionary_size))

    expected_signs, expected_dictionary = family_data()
    expected_masks = masks_from_signs(expected_signs).astype(np.uint32)
    assert np.array_equal(masks, expected_masks)
    assert np.array_equal(denominators, np.stack(expected_dictionary))

    affine = families.core.affine_matrix(N).astype(object)
    for denominator_tuple in denominators:
        values = affine @ denominator_tuple.astype(object).T
        assert np.all(values > 0)
        assert all(
            np.all(row[1:] > 0) or np.all(row[1:] < 0)
            for row in denominator_tuple
        )

    signs = signs_from_masks(masks).astype(object)
    big_rows = {
        int(target_index): np.array(
            [int(value) for value in big_coefficients[row]], dtype=object
        )
        for row, target_index in enumerate(big_target_indices)
    }
    assert len(big_rows) == len(big_target_indices)
    assert all(np.all(coefficients[target_index] == 0) for target_index in big_rows)
    verified = 0
    for dictionary_index in range(dictionary_size):
        target_indices = np.flatnonzero(witness_indices == dictionary_index)
        if not len(target_indices):
            continue
        matrix = cleared_matrix(denominators[dictionary_index])
        for target_index_value in target_indices:
            target_index = int(target_index_value)
            exact_coefficients = big_rows.get(
                target_index, coefficients[target_index].astype(object)
            )
            values = matrix @ exact_coefficients
            signed = signs[target_index] * values
            minimum = int(min(signed))
            assert minimum > 0
            verified += 1
        print(
            f"verified dictionary {dictionary_index}: "
            f"{len(target_indices)} targets",
            flush=True,
        )
    assert verified == EXPECTED_TARGETS
    print(
        f"verified exact H4 certificates for all {verified} face-family targets",
        flush=True,
    )


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--archive", type=Path, default=DEFAULT_ARCHIVE)
    parser.add_argument("--build", action="store_true")
    arguments = parser.parse_args()
    if arguments.build:
        build_archive(arguments.archive)
    else:
        verify_archive(arguments.archive)


if __name__ == "__main__":
    main()
