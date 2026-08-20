// Exhaustively enumerate support-17 quadratic circuits on the five-cube.
//
// Compile with:
//   c++ -O3 -std=c++20 enumerate_n5_support17_circuit_orbits.cpp -o /tmp/enumerate_n5_support17
//
// A support-17 circuit is complementary to a 15-element rank-15 hyperplane
// of the 32 by 16 quadratic Fourier configuration.  The traversal marks
// complete orbits of 15-subsets under all 3840 cube automorphisms.  It uses a
// 2^32-bit table, so peak memory is about 540 MB.

#include <algorithm>
#include <array>
#include <cassert>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <map>
#include <numeric>
#include <set>
#include <string>
#include <unordered_set>
#include <vector>

namespace {

constexpr int N = 5;
constexpr int VERTICES = 32;
constexpr int COLUMNS = 16;
constexpr int ZERO_SIZE = 15;
constexpr std::uint64_t PRIME = 4294967311ULL;
constexpr int FULL_GROUP_SIZE = 3840;
constexpr int HEAD_GROUP_SIZE = 240;

using VertexMap = std::array<std::uint8_t, VERTICES>;
using FeatureRow = std::array<std::int64_t, COLUMNS>;
using ModularRow = std::array<std::uint64_t, COLUMNS>;
using CoefficientVector = std::array<std::int64_t, COLUMNS>;

std::uint64_t multiply_mod(std::uint64_t first, std::uint64_t second) {
    return static_cast<std::uint64_t>(
        (static_cast<unsigned __int128>(first) * second) % PRIME
    );
}

std::uint64_t power_mod(std::uint64_t base, std::uint64_t exponent) {
    std::uint64_t answer = 1;
    while (exponent) {
        if (exponent & 1ULL) {
            answer = multiply_mod(answer, base);
        }
        base = multiply_mod(base, base);
        exponent >>= 1;
    }
    return answer;
}

std::uint64_t subtract_mod(std::uint64_t first, std::uint64_t second) {
    return first >= second ? first - second : first + PRIME - second;
}

std::vector<VertexMap> cube_group(bool head_symmetry_only) {
    std::vector<VertexMap> answer;
    std::array<int, N> permutation = {0, 1, 2, 3, 4};
    do {
        std::array<int, 2> head_flips = {0, VERTICES - 1};
        if (head_symmetry_only) {
            for (int flip : head_flips) {
                VertexMap map{};
                for (int vertex = 0; vertex < VERTICES; ++vertex) {
                    int permuted = 0;
                    for (int target = 0; target < N; ++target) {
                        permuted |= ((vertex >> permutation[target]) & 1)
                            << target;
                    }
                    map[vertex] = static_cast<std::uint8_t>(permuted ^ flip);
                }
                answer.push_back(map);
            }
        } else {
            for (int flip = 0; flip < VERTICES; ++flip) {
                VertexMap map{};
                for (int vertex = 0; vertex < VERTICES; ++vertex) {
                    int permuted = 0;
                    for (int target = 0; target < N; ++target) {
                        permuted |= ((vertex >> permutation[target]) & 1)
                            << target;
                    }
                    map[vertex] = static_cast<std::uint8_t>(permuted ^ flip);
                }
                answer.push_back(map);
            }
        }
    } while (std::next_permutation(permutation.begin(), permutation.end()));
    return answer;
}

std::array<FeatureRow, VERTICES> quadratic_features() {
    std::array<FeatureRow, VERTICES> features{};
    for (int vertex = 0; vertex < VERTICES; ++vertex) {
        std::array<int, N> sign{};
        for (int coordinate = 0; coordinate < N; ++coordinate) {
            sign[coordinate] = ((vertex >> coordinate) & 1) ? -1 : 1;
        }
        int column = 0;
        features[vertex][column++] = 1;
        for (int coordinate = 0; coordinate < N; ++coordinate) {
            features[vertex][column++] = sign[coordinate];
        }
        for (int first = 0; first < N; ++first) {
            for (int second = first + 1; second < N; ++second) {
                features[vertex][column++] = sign[first] * sign[second];
            }
        }
        assert(column == COLUMNS);
    }
    return features;
}

class OrbitLookup {
public:
    explicit OrbitLookup(const std::vector<VertexMap>& group)
        : group_size_(static_cast<int>(group.size())),
          table_(static_cast<std::size_t>(group_size_) * 4 * 256, 0) {
        for (int element = 0; element < group_size_; ++element) {
            std::array<int, VERTICES> inverse{};
            for (int output = 0; output < VERTICES; ++output) {
                inverse[group[element][output]] = output;
            }
            for (int chunk = 0; chunk < 4; ++chunk) {
                for (int value = 0; value < 256; ++value) {
                    std::uint32_t transformed = 0;
                    for (int bit = 0; bit < 8; ++bit) {
                        if ((value >> bit) & 1) {
                            int source = 8 * chunk + bit;
                            transformed |= std::uint32_t{1} << inverse[source];
                        }
                    }
                    table_[index(element, chunk, value)] = transformed;
                }
            }
        }
    }

    std::uint32_t transform(int element, std::uint32_t mask) const {
        return table_[index(element, 0, mask & 255U)]
            | table_[index(element, 1, (mask >> 8) & 255U)]
            | table_[index(element, 2, (mask >> 16) & 255U)]
            | table_[index(element, 3, (mask >> 24) & 255U)];
    }

    int size() const { return group_size_; }

private:
    std::size_t index(int element, int chunk, int value) const {
        return (static_cast<std::size_t>(element) * 4 + chunk) * 256 + value;
    }

    int group_size_;
    std::vector<std::uint32_t> table_;
};

struct NullspaceResult {
    int rank = 0;
    int free_column = -1;
    std::array<std::uint64_t, COLUMNS> vector{};
};

NullspaceResult modular_nullspace(
    std::uint32_t zero_mask,
    const std::array<FeatureRow, VERTICES>& features
) {
    std::array<ModularRow, ZERO_SIZE> matrix{};
    int row = 0;
    for (int vertex = 0; vertex < VERTICES; ++vertex) {
        if (!((zero_mask >> vertex) & 1U)) {
            continue;
        }
        for (int column = 0; column < COLUMNS; ++column) {
            matrix[row][column] = features[vertex][column] > 0
                ? 1ULL
                : PRIME - 1;
        }
        ++row;
    }
    assert(row == ZERO_SIZE);

    std::array<int, ZERO_SIZE> pivot_columns{};
    int rank = 0;
    for (int column = 0; column < COLUMNS && rank < ZERO_SIZE; ++column) {
        int pivot = rank;
        while (pivot < ZERO_SIZE && matrix[pivot][column] == 0) {
            ++pivot;
        }
        if (pivot == ZERO_SIZE) {
            continue;
        }
        std::swap(matrix[rank], matrix[pivot]);
        std::uint64_t inverse = power_mod(
            matrix[rank][column], PRIME - 2
        );
        for (int current = column; current < COLUMNS; ++current) {
            matrix[rank][current] = multiply_mod(
                matrix[rank][current], inverse
            );
        }
        for (int lower = rank + 1; lower < ZERO_SIZE; ++lower) {
            std::uint64_t factor = matrix[lower][column];
            if (factor == 0) {
                continue;
            }
            for (int current = column; current < COLUMNS; ++current) {
                matrix[lower][current] = subtract_mod(
                    matrix[lower][current],
                    multiply_mod(factor, matrix[rank][current])
                );
            }
        }
        pivot_columns[rank] = column;
        ++rank;
    }

    NullspaceResult result;
    result.rank = rank;
    if (rank != ZERO_SIZE) {
        return result;
    }
    std::array<bool, COLUMNS> pivot{};
    for (int index = 0; index < rank; ++index) {
        pivot[pivot_columns[index]] = true;
    }
    for (int column = 0; column < COLUMNS; ++column) {
        if (!pivot[column]) {
            result.free_column = column;
            break;
        }
    }
    assert(result.free_column >= 0);
    result.vector[result.free_column] = 1;
    for (int index = rank - 1; index >= 0; --index) {
        int column = pivot_columns[index];
        std::uint64_t total = 0;
        for (int current = column + 1; current < COLUMNS; ++current) {
            total += multiply_mod(
                matrix[index][current], result.vector[current]
            );
            if (total >= PRIME) {
                total %= PRIME;
            }
        }
        total %= PRIME;
        result.vector[column] = total == 0 ? 0 : PRIME - total;
    }
    return result;
}

std::uint64_t evaluate_modular(
    const FeatureRow& row,
    const std::array<std::uint64_t, COLUMNS>& coefficients
) {
    std::uint64_t positive = 0;
    std::uint64_t negative = 0;
    for (int column = 0; column < COLUMNS; ++column) {
        if (row[column] > 0) {
            positive += coefficients[column];
        } else {
            negative += coefficients[column];
        }
    }
    positive %= PRIME;
    negative %= PRIME;
    return subtract_mod(positive, negative);
}

std::int64_t bareiss_determinant(
    std::array<std::array<std::int64_t, ZERO_SIZE>, ZERO_SIZE> matrix
) {
    std::int64_t previous = 1;
    int sign = 1;
    for (int pivot_index = 0; pivot_index < ZERO_SIZE - 1; ++pivot_index) {
        int pivot = pivot_index;
        while (pivot < ZERO_SIZE && matrix[pivot][pivot_index] == 0) {
            ++pivot;
        }
        if (pivot == ZERO_SIZE) {
            return 0;
        }
        if (pivot != pivot_index) {
            std::swap(matrix[pivot], matrix[pivot_index]);
            sign = -sign;
        }
        std::int64_t pivot_value = matrix[pivot_index][pivot_index];
        for (int row = pivot_index + 1; row < ZERO_SIZE; ++row) {
            for (int column = pivot_index + 1; column < ZERO_SIZE; ++column) {
                __int128 numerator =
                    static_cast<__int128>(matrix[row][column]) * pivot_value
                    - static_cast<__int128>(matrix[row][pivot_index])
                        * matrix[pivot_index][column];
                assert(numerator % previous == 0);
                __int128 quotient = numerator / previous;
                assert(quotient >= INT64_MIN && quotient <= INT64_MAX);
                matrix[row][column] = static_cast<std::int64_t>(quotient);
            }
            matrix[row][pivot_index] = 0;
        }
        previous = pivot_value;
    }
    return sign * matrix[ZERO_SIZE - 1][ZERO_SIZE - 1];
}

std::array<std::int64_t, COLUMNS> exact_quadratic_coefficients(
    std::uint32_t zero_mask,
    int free_column,
    const std::array<std::uint64_t, COLUMNS>& modular_vector,
    const std::array<FeatureRow, VERTICES>& features
) {
    std::array<std::array<std::int64_t, ZERO_SIZE>, ZERO_SIZE> minor{};
    int row = 0;
    for (int vertex = 0; vertex < VERTICES; ++vertex) {
        if (!((zero_mask >> vertex) & 1U)) {
            continue;
        }
        int target = 0;
        for (int column = 0; column < COLUMNS; ++column) {
            if (column != free_column) {
                minor[row][target++] = features[vertex][column];
            }
        }
        assert(target == ZERO_SIZE);
        ++row;
    }
    std::int64_t free_cofactor = bareiss_determinant(minor);
    if (free_column & 1) {
        free_cofactor = -free_cofactor;
    }
    assert(free_cofactor != 0);
    std::uint64_t scale = free_cofactor >= 0
        ? static_cast<std::uint64_t>(free_cofactor)
        : PRIME - static_cast<std::uint64_t>(-free_cofactor);

    std::array<std::int64_t, COLUMNS> answer{};
    for (int column = 0; column < COLUMNS; ++column) {
        std::uint64_t residue = multiply_mod(modular_vector[column], scale);
        answer[column] = residue <= PRIME / 2
            ? static_cast<std::int64_t>(residue)
            : -static_cast<std::int64_t>(PRIME - residue);
    }
    assert(answer[free_column] == free_cofactor);
    return answer;
}

std::int64_t evaluate_exact(
    const FeatureRow& row,
    const CoefficientVector& coefficients
) {
    std::int64_t answer = 0;
    for (int column = 0; column < COLUMNS; ++column) {
        answer += row[column] * coefficients[column];
    }
    return answer;
}

CoefficientVector primitive_coefficients(CoefficientVector coefficients) {
    std::int64_t divisor = 0;
    for (std::int64_t value : coefficients) {
        divisor = std::gcd(divisor, std::abs(value));
    }
    assert(divisor > 0);
    for (std::int64_t& value : coefficients) {
        value /= divisor;
    }
    return coefficients;
}

int edge_column(int first, int second) {
    if (first > second) {
        std::swap(first, second);
    }
    int column = 6;
    for (int left = 0; left < N; ++left) {
        for (int right = left + 1; right < N; ++right) {
            if (left == first && right == second) {
                return column;
            }
            ++column;
        }
    }
    assert(false);
    return -1;
}

int c5_edge_sign(int first, int second) {
    if (first > second) {
        std::swap(first, second);
    }
    return (second == first + 1 || (first == 0 && second == 4)) ? 1 : -1;
}

void add_c5_images(
    const CoefficientVector& source,
    std::set<CoefficientVector>& rays
) {
    std::array<int, N> permutation = {0, 1, 2, 3, 4};
    do {
        for (int flip_mask = 0; flip_mask < (1 << N); ++flip_mask) {
            std::array<int, N> flip{};
            for (int index = 0; index < N; ++index) {
                flip[index] = ((flip_mask >> index) & 1) ? -1 : 1;
            }
            for (int output_sign : {-1, 1}) {
                CoefficientVector transformed{};
                transformed[0] = output_sign * source[0];
                for (int index = 0; index < N; ++index) {
                    transformed[1 + index] = output_sign * flip[index]
                        * source[1 + permutation[index]];
                }
                bool compatible = true;
                bool nonzero_edge = false;
                for (int first = 0; first < N; ++first) {
                    for (int second = first + 1; second < N; ++second) {
                        int source_column = edge_column(
                            permutation[first], permutation[second]
                        );
                        int target_column = edge_column(first, second);
                        transformed[target_column] = output_sign
                            * flip[first] * flip[second]
                            * source[source_column];
                        int signed_value = c5_edge_sign(first, second)
                            * transformed[target_column];
                        compatible = compatible && signed_value >= 0;
                        nonzero_edge = nonzero_edge || signed_value > 0;
                    }
                }
                if (!compatible || !nonzero_edge) {
                    continue;
                }
                // The C++ feature convention uses 1-2x, while the Python
                // verifier uses 2x-1.  Only the five linear coefficients
                // change sign between the two conventions.
                for (int index = 0; index < N; ++index) {
                    transformed[1 + index] = -transformed[1 + index];
                }
                rays.insert(primitive_coefficients(transformed));
            }
        }
    } while (std::next_permutation(permutation.begin(), permutation.end()));
}

std::array<std::int8_t, VERTICES> exact_circuit_signs(
    std::uint32_t zero_mask,
    const NullspaceResult& nullspace,
    const std::array<FeatureRow, VERTICES>& features
) {
    auto coefficients = exact_quadratic_coefficients(
        zero_mask, nullspace.free_column, nullspace.vector, features
    );
    std::array<std::int8_t, VERTICES> signs{};
    int zero_count = 0;
    for (int vertex = 0; vertex < VERTICES; ++vertex) {
        std::int64_t value = 0;
        for (int column = 0; column < COLUMNS; ++column) {
            value += features[vertex][column] * coefficients[column];
        }
        if (value == 0) {
            ++zero_count;
            assert((zero_mask >> vertex) & 1U);
            continue;
        }
        assert(!((zero_mask >> vertex) & 1U));
        int parity = (__builtin_popcount(static_cast<unsigned>(vertex)) & 1)
            ? -1
            : 1;
        signs[vertex] = static_cast<std::int8_t>(
            parity * (value > 0 ? 1 : -1)
        );
    }
    assert(zero_count == ZERO_SIZE);
    return signs;
}

std::uint64_t canonical_sign_code(
    const std::array<std::int8_t, VERTICES>& signs,
    int translation,
    const std::vector<VertexMap>& head_group
) {
    std::array<std::uint64_t, VERTICES> powers{};
    powers[0] = 1;
    for (int index = 1; index < VERTICES; ++index) {
        powers[index] = 3 * powers[index - 1];
    }
    std::uint64_t best = UINT64_MAX;
    for (const VertexMap& map : head_group) {
        std::uint64_t code = 0;
        std::uint64_t complement = 0;
        for (int vertex = 0; vertex < VERTICES; ++vertex) {
            int source = map[vertex] ^ translation;
            int digit = static_cast<int>(signs[source]) + 1;
            code += static_cast<std::uint64_t>(digit) * powers[vertex];
            complement += static_cast<std::uint64_t>(2 - digit)
                * powers[vertex];
        }
        best = std::min(best, std::min(code, complement));
    }
    return best;
}

int main_impl(const char* record_path, const char* c5_ray_path) {
    auto full_group = cube_group(false);
    auto head_group = cube_group(true);
    assert(static_cast<int>(full_group.size()) == FULL_GROUP_SIZE);
    assert(static_cast<int>(head_group.size()) == HEAD_GROUP_SIZE);
    OrbitLookup full_lookup(full_group);
    OrbitLookup head_lookup(head_group);
    auto features = quadratic_features();

    constexpr std::size_t VISITED_WORDS = std::size_t{1} << 26;
    std::vector<std::uint64_t> visited(VISITED_WORDS, 0);
    auto is_visited = [&](std::uint32_t mask) {
        return (visited[mask >> 6] >> (mask & 63U)) & 1ULL;
    };
    auto mark_visited = [&](std::uint32_t mask) {
        visited[mask >> 6] |= 1ULL << (mask & 63U);
    };

    std::uint64_t scanned = 0;
    std::uint64_t subset_orbits = 0;
    std::uint64_t rank15_orbits = 0;
    std::uint64_t support17_full_orbits = 0;
    std::uint64_t support17_circuits = 0;
    std::uint64_t support17_head_orbits = 0;
    std::uint64_t representative_checksum = 0;
    std::map<int, std::uint64_t> full_orbit_size_distribution;
    std::map<int, std::uint64_t> head_split_distribution;
    std::vector<std::uint64_t> head_orbit_codes;
    std::unordered_set<std::uint32_t> cocircuit_zero_orbits;
    std::set<CoefficientVector> c5_rays;
    std::map<int, std::uint64_t> cocircuit_zero_size_distribution;

    std::uint64_t combination = (std::uint64_t{1} << ZERO_SIZE) - 1;
    const std::uint64_t limit = std::uint64_t{1} << VERTICES;
    while (combination < limit) {
        std::uint32_t mask = static_cast<std::uint32_t>(combination);
        ++scanned;
        if (!is_visited(mask)) {
            ++subset_orbits;
            for (int element = 0; element < full_lookup.size(); ++element) {
                mark_visited(full_lookup.transform(element, mask));
            }

            NullspaceResult nullspace = modular_nullspace(mask, features);
            if (nullspace.rank == ZERO_SIZE) {
                ++rank15_orbits;
                int zero_count = 0;
                std::uint32_t full_zero_mask = 0;
                for (int vertex = 0; vertex < VERTICES; ++vertex) {
                    if (evaluate_modular(
                            features[vertex], nullspace.vector
                        ) == 0) {
                        ++zero_count;
                        full_zero_mask |= std::uint32_t{1} << vertex;
                    }
                }
                if (c5_ray_path != nullptr) {
                    std::uint32_t canonical_zero = UINT32_MAX;
                    for (int element = 0; element < full_lookup.size(); ++element) {
                        canonical_zero = std::min(
                            canonical_zero,
                            full_lookup.transform(element, full_zero_mask)
                        );
                    }
                    if (cocircuit_zero_orbits.insert(canonical_zero).second) {
                        ++cocircuit_zero_size_distribution[zero_count];
                        CoefficientVector coefficients = exact_quadratic_coefficients(
                            mask,
                            nullspace.free_column,
                            nullspace.vector,
                            features
                        );
                        for (int vertex = 0; vertex < VERTICES; ++vertex) {
                            assert(
                                (evaluate_exact(features[vertex], coefficients) == 0)
                                == ((full_zero_mask >> vertex) & 1U)
                            );
                        }
                        add_c5_images(coefficients, c5_rays);
                    }
                }
                if (zero_count == ZERO_SIZE) {
                    ++support17_full_orbits;
                    representative_checksum += mask;
                    std::vector<std::uint32_t> orbit;
                    orbit.reserve(FULL_GROUP_SIZE);
                    for (int element = 0; element < full_lookup.size(); ++element) {
                        orbit.push_back(full_lookup.transform(element, mask));
                    }
                    std::sort(orbit.begin(), orbit.end());
                    int orbit_size = static_cast<int>(
                        std::unique(orbit.begin(), orbit.end()) - orbit.begin()
                    );
                    support17_circuits += orbit_size;
                    ++full_orbit_size_distribution[orbit_size];

                    auto signs = exact_circuit_signs(
                        mask, nullspace, features
                    );
                    std::unordered_set<std::uint64_t> head_codes;
                    std::unordered_set<std::uint32_t> head_zero_masks;
                    for (int translation = 0; translation < 16; ++translation) {
                        head_codes.insert(canonical_sign_code(
                            signs, translation, head_group
                        ));
                        std::uint32_t translated = full_lookup.transform(
                            translation, mask
                        );
                        std::uint32_t canonical_zero = UINT32_MAX;
                        for (int element = 0; element < head_lookup.size(); ++element) {
                            canonical_zero = std::min(
                                canonical_zero,
                                head_lookup.transform(element, translated)
                            );
                        }
                        head_zero_masks.insert(canonical_zero);
                    }
                    assert(head_codes.size() == head_zero_masks.size());
                    int split = static_cast<int>(head_codes.size());
                    support17_head_orbits += split;
                    ++head_split_distribution[split];
                    head_orbit_codes.insert(
                        head_orbit_codes.end(),
                        head_codes.begin(),
                        head_codes.end()
                    );
                }
            }
        }

        if (scanned % 50000000ULL == 0) {
            std::cerr
                << "scanned=" << scanned
                << " subset_orbits=" << subset_orbits
                << " support17_full_orbits=" << support17_full_orbits
                << '\n';
        }
        std::uint64_t lowest = combination & (~combination + 1);
        std::uint64_t raised = combination + lowest;
        if (raised >= limit) {
            break;
        }
        combination = (((raised ^ combination) >> 2) / lowest) | raised;
    }

    std::cout << "prime: " << PRIME << '\n';
    std::cout << "15-by-15 Hadamard bound: 661735514" << '\n';
    std::cout << "16-by-16 Hadamard bound: 4294967296" << '\n';
    std::cout << "15-subsets scanned: " << scanned << '\n';
    std::cout << "full-cube 15-subset orbits: " << subset_orbits << '\n';
    std::cout << "rank-15 full-cube orbits: " << rank15_orbits << '\n';
    std::cout << "support-17 full-cube circuit orbits: "
              << support17_full_orbits << '\n';
    std::cout << "support-17 circuits up to global sign: "
              << support17_circuits << '\n';
    std::cout << "support-17 head-symmetry circuit orbits: "
              << support17_head_orbits << '\n';
    std::cout << "representative-mask checksum: "
              << representative_checksum << '\n';
    std::cout << "full orbit-size distribution:";
    for (const auto& [size, count] : full_orbit_size_distribution) {
        std::cout << ' ' << size << ':' << count;
    }
    std::cout << '\n';
    std::cout << "head split distribution:";
    for (const auto& [size, count] : head_split_distribution) {
        std::cout << ' ' << size << ':' << count;
    }
    std::cout << '\n';
    std::sort(head_orbit_codes.begin(), head_orbit_codes.end());
    auto unique_end = std::unique(
        head_orbit_codes.begin(), head_orbit_codes.end()
    );
    assert(unique_end == head_orbit_codes.end());
    assert(head_orbit_codes.size() == support17_head_orbits);
    if (record_path != nullptr) {
        std::ofstream records(record_path);
        assert(records.good());
        records << "ternary_circuit_code\n";
        for (std::uint64_t code : head_orbit_codes) {
            records << code << '\n';
        }
        records.close();
        std::cout << "wrote head-orbit codes: " << record_path << '\n';
    }
    if (c5_ray_path != nullptr) {
        std::ofstream records(c5_ray_path);
        assert(records.good());
        records << "c0,c1,c2,c3,c4,c5,c01,c02,c03,c04,c12,c13,c14,c23,c24,c34\n";
        for (const CoefficientVector& ray : c5_rays) {
            for (int column = 0; column < COLUMNS; ++column) {
                if (column) {
                    records << ',';
                }
                records << ray[column];
            }
            records << '\n';
        }
        records.close();
        std::cout << "cocircuit full-cube orbits: "
                  << cocircuit_zero_orbits.size() << '\n';
        std::cout << "cocircuit zero-size distribution:";
        for (const auto& [size, count] : cocircuit_zero_size_distribution) {
            std::cout << ' ' << size << ':' << count;
        }
        std::cout << '\n';
        std::cout << "closed-C5 primitive rays: " << c5_rays.size() << '\n';
        std::cout << "wrote closed-C5 rays: " << c5_ray_path << '\n';
    }
    return 0;
}

}  // namespace

int main(int argc, char** argv) {
    if (argc == 3 && std::string(argv[1]) == "--c5-rays") {
        return main_impl(nullptr, argv[2]);
    }
    assert(argc <= 2);
    return main_impl(argc == 2 ? argv[1] : nullptr, nullptr);
}
