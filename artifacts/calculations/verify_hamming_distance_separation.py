#!/usr/bin/env python3
"""Verify the finite sign-rank certificate for the 12-bit separation.

The function is the threshold at three of the Hamming distance between two
six-bit strings.  Restricting its communication sign matrix to the eight
listed columns gives 64 row-sign classes.  The verifier checks that these
classes meet every generic two-dimensional tope cycle in eight coordinates.
"""

from itertools import permutations


INPUT_BITS = 6
TOPE_COORDINATES = 8
FULL_SIGN_MASK = (1 << TOPE_COORDINATES) - 1
SELECTED_COLUMNS = (43, 29, 37, 19, 48, 36, 8, 62)
EXPECTED_CANONICAL_ROWS = (
    1,
    2,
    3,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    19,
    24,
    25,
    26,
    27,
    28,
    32,
    36,
    37,
    38,
    39,
    47,
    48,
    49,
    50,
    52,
    53,
    54,
    55,
    61,
    62,
    63,
    64,
    65,
    67,
    69,
    70,
    72,
    73,
    74,
    75,
    76,
    77,
    79,
    82,
    88,
    91,
    94,
    98,
    100,
    103,
    110,
    112,
    113,
    115,
    116,
    117,
    118,
    119,
    121,
    122,
    124,
    125,
    127,
)


def hamming_weight(value):
    return bin(value).count("1")


def row_code(x):
    """Encode sign +1 as bit 0 and sign -1 as bit 1."""
    code = 0
    for index, y in enumerate(SELECTED_COLUMNS):
        if hamming_weight(x ^ y) < 3:
            code |= 1 << index
    return code


def canonical_antipodal_representative(code):
    return min(code, code ^ FULL_SIGN_MASK)


def path_is_hit(start, order, row_classes):
    vertex = start
    for coordinate in order:
        if vertex in row_classes:
            return True
        vertex ^= 1 << coordinate
    return False


def main():
    assert len(SELECTED_COLUMNS) == TOPE_COORDINATES
    assert len(set(SELECTED_COLUMNS)) == TOPE_COORDINATES
    assert all(0 <= y < (1 << INPUT_BITS) for y in SELECTED_COLUMNS)

    raw_rows = tuple(row_code(x) for x in range(1 << INPUT_BITS))
    canonical_rows = tuple(
        sorted(canonical_antipodal_representative(code) for code in raw_rows)
    )
    assert len(set(raw_rows)) == 64
    assert len(set(canonical_rows)) == 64
    assert canonical_rows == EXPECTED_CANONICAL_ROWS

    row_classes = frozenset(raw_rows) | frozenset(
        code ^ FULL_SIGN_MASK for code in raw_rows
    )
    assert len(row_classes) == 128

    path_count = 0
    for start in range(1 << (TOPE_COORDINATES - 1)):
        for order in permutations(range(TOPE_COORDINATES)):
            path_count += 1
            assert path_is_hit(start, order, row_classes), (start, order)

    assert path_count == 128 * 40320
    print("input bits:", 2 * INPUT_BITS)
    print("selected column codes:", SELECTED_COLUMNS)
    print("distinct antipodal row classes:", len(canonical_rows))
    print("antipodal coordinate-flip paths:", path_count)
    print("certificate: verified")


if __name__ == "__main__":
    main()
