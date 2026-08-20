#!/usr/bin/env bash

set -euo pipefail

script_dir="$(CDPATH='' cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repository_dir="$(dirname -- "$(dirname -- "$script_dir")")"
package_dir="$repository_dir/formalization"
axiom_check="$script_dir/AxiomCheck.lean"
fetch_cache=false

usage() {
  echo "Usage: $0 [--fetch-cache]" >&2
}

if [ "${1:-}" = "--fetch-cache" ]; then
  fetch_cache=true
  shift
fi
if [ "$#" -ne 0 ]; then
  usage
  exit 2
fi

for command_name in git lake rg; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Required command not found: $command_name" >&2
    exit 127
  fi
done

if [ ! -f "$package_dir/lakefile.toml" ]; then
  echo "Lean package not found: $package_dir" >&2
  exit 1
fi
if [ ! -f "$axiom_check" ]; then
  echo "Axiom checker not found: $axiom_check" >&2
  exit 1
fi

cd "$package_dir"
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "The formalization validator must run from a Git worktree." >&2
  exit 1
fi

if $fetch_cache; then
  echo "=== Fetching the pinned mathlib cache ==="
  if lake exe cache get; then
    echo "CACHE_RC=0"
  else
    cache_rc=$?
    echo "CACHE_RC=$cache_rc"
    exit "$cache_rc"
  fi
fi

tracked_lean_files=()
while IFS= read -r -d '' source_file; do
  tracked_lean_files+=("$source_file")
done < <(git ls-files -z --cached -- '*.lean')

if [ "${#tracked_lean_files[@]}" -eq 0 ]; then
  echo "No tracked Lean library sources found." >&2
  exit 1
fi

library_targets=()
for source_file in "${tracked_lean_files[@]}"; do
  library_targets+=("./$source_file")
done

echo "=== Building ${#library_targets[@]} tracked Lean library sources ==="
if lake build "${library_targets[@]}"; then
  echo "BUILD_RC=0"
else
  build_rc=$?
  echo "BUILD_RC=$build_rc"
  exit "$build_rc"
fi

echo "=== Rejecting Lean proof placeholders ==="
if placeholder_output="$(rg -n --color=never 'sorry|admit\b' -- "${tracked_lean_files[@]}" "$axiom_check")"; then
  printf '%s\n' "$placeholder_output"
  echo "Lean proof placeholders are not allowed." >&2
  echo "PLACEHOLDER_RC=1"
  exit 1
else
  placeholder_rc=$?
  if [ "$placeholder_rc" -ne 1 ]; then
    echo "Failed to scan the Lean sources for proof placeholders." >&2
    echo "PLACEHOLDER_RC=$placeholder_rc"
    exit "$placeholder_rc"
  fi
  echo "PLACEHOLDER_RC=0"
fi

echo "=== Auditing every theorem in ${#tracked_lean_files[@]} tracked Lean modules ==="
if lake env lean --run "$axiom_check" "${tracked_lean_files[@]}"; then
  echo "AXIOM_RC=0"
else
  axiom_rc=$?
  echo "AXIOM_RC=$axiom_rc"
  exit "$axiom_rc"
fi

echo "Validation completed successfully."
