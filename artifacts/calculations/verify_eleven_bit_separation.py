#!/usr/bin/env python3
"""Verify the exact certificate for the 11-bit strict separation.

The verifier checks the selected 35 by 8 sign submatrix using integer
arithmetic, then exhaustively checks that its row classes meet every generic
two-dimensional tope cycle in eight coordinates.
"""

from itertools import permutations, product


X_BITS = 6
Y_BITS = 5
TOPE_COORDINATES = 8
FULL_SIGN_MASK = (1 << TOPE_COORDINATES) - 1

ROW_CODES = (
    0,
    3,
    5,
    10,
    12,
    15,
    18,
    20,
    23,
    30,
    34,
    36,
    39,
    46,
    54,
    65,
    72,
    75,
    77,
    80,
    83,
    85,
    90,
    92,
    95,
    96,
    99,
    101,
    106,
    108,
    111,
    114,
    116,
    119,
    126,
)

# Column j is the five-bit string with code SELECTED_Y_CODES[j].
SELECTED_Y_CODES = (2, 30, 0, 5, 1, 25, 21, 18)


def bits(value, width):
    return tuple((value >> index) & 1 for index in range(width))


def q_value(x_code, y_code):
    x1, x2, x3, x4, x5, x6 = bits(x_code, X_BITS)
    y1, y2, y3, y4, y5 = bits(y_code, Y_BITS)
    return (
        1
        - 2 * x3
        + 8 * y5
        - 16 * x1 * y2
        + 14 * x1 * y4
        - 14 * x1 * y5
        - 22 * x2 * y4
        + 16 * x2 * y5
        + 2 * x3 * y1
        + 12 * x3 * y2
        + 6 * x3 * y5
        - 18 * x4 * y3
        - 2 * x5 * y1
        - 14 * x5 * y3
        - 16 * x6 * y5
        + 16 * y1 * y3
        + 22 * y2 * y5
        - 12 * y3 * y5
    )


def sign_row_code(x_code):
    code = 0
    for index, y_code in enumerate(SELECTED_Y_CODES):
        if q_value(x_code, y_code) < 0:
            code |= 1 << index
    return code


def antipodal_lift(rows):
    return frozenset(rows) | frozenset(value ^ FULL_SIGN_MASK for value in rows)


def path_is_hit(start, order, row_classes):
    vertex = start
    for coordinate in order:
        if vertex in row_classes:
            return True
        vertex ^= 1 << coordinate
    return False


def main():
    assert len(ROW_CODES) == 35
    assert len(set(ROW_CODES)) == 35
    assert all(value < 128 for value in ROW_CODES)
    assert len(set(SELECTED_Y_CODES)) == TOPE_COORDINATES
    assert all(0 <= value < (1 << Y_BITS) for value in SELECTED_Y_CODES)

    selected_values = []
    for row_code in ROW_CODES:
        x_code = row_code & ((1 << X_BITS) - 1)
        assert sign_row_code(x_code) == row_code
        selected_values.extend(
            q_value(x_code, y_code) for y_code in SELECTED_Y_CODES
        )
    assert len(set(row_code & 63 for row_code in ROW_CODES)) == 35
    assert min(abs(value) for value in selected_values) == 1

    full_cube_values = []
    for x_code, y_code in product(range(1 << X_BITS), range(1 << Y_BITS)):
        value = q_value(x_code, y_code)
        assert isinstance(value, int)
        assert value % 2 == 1
        full_cube_values.append(value)

    row_classes = antipodal_lift(frozenset(ROW_CODES))
    path_count = 0
    for start in range(1 << (TOPE_COORDINATES - 1)):
        for order in permutations(range(TOPE_COORDINATES)):
            path_count += 1
            assert path_is_hit(start, order, row_classes), (start, order)

    assert path_count == 128 * 40320
    print("input bits:", X_BITS + Y_BITS)
    print("selected rows:", len(ROW_CODES))
    print("selected y codes:", SELECTED_Y_CODES)
    print("minimum absolute selected Q value:", min(map(abs, selected_values)))
    print("full-cube Q range:", (min(full_cube_values), max(full_cube_values)))
    print("antipodal coordinate-flip paths:", path_count)
    print("certificate: verified")


if __name__ == "__main__":
    main()
