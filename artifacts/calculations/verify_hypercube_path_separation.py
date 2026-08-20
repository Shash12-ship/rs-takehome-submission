#!/usr/bin/env python3
"""Verify the finite hypercube-path certificates used in Theorems 180 and 181."""

from itertools import permutations


N = 8
FULL = (1 << N) - 1


def parity(value):
    return bin(value).count("1") % 2


def bits(value):
    return tuple((value >> index) & 1 for index in range(N))


def is_row_representative(value):
    row = bits(value)
    return (
        row[7] == 0
        and parity(value) == 0
        and (row[3] == 0 or row[0] ^ row[1] ^ row[2] == 1)
    )


STRUCTURED_ROWS = frozenset(
    value for value in range(1 << N) if is_row_representative(value)
)

COMPACT_ROWS = frozenset(
    {
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
    }
)


def antipodal_lift(rows):
    return rows | frozenset(value ^ FULL for value in rows)


def path_is_hit(start, order, row_classes):
    vertex = start
    for coordinate in order:
        if vertex in row_classes:
            return True
        vertex ^= 1 << coordinate
    return False


def main():
    assert len(STRUCTURED_ROWS) == 48
    assert len(COMPACT_ROWS) == 35
    assert all(value < 128 and parity(value) == 0 for value in COMPACT_ROWS)

    structured_classes = antipodal_lift(STRUCTURED_ROWS)
    compact_classes = antipodal_lift(COMPACT_ROWS)

    path_count = 0
    for start in range(1 << (N - 1)):
        for order in permutations(range(N)):
            path_count += 1
            assert path_is_hit(start, order, structured_classes), (start, order)
            assert path_is_hit(start, order, compact_classes), (start, order)

    assert path_count == 128 * 40320
    print("structured row representatives:", len(STRUCTURED_ROWS))
    print("compact row representatives:", len(COMPACT_ROWS))
    print("antipodal coordinate-flip paths:", path_count)
    print("certificate: verified")


if __name__ == "__main__":
    main()
