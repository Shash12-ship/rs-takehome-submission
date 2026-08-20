#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEX_FILE="${1:-$SCRIPT_DIR/../intro-materials/proposal.tex}"
cd "$(dirname "$TEX_FILE")"
TEX_FILE="$(basename "$TEX_FILE")"
BASE="${TEX_FILE%.tex}"

pdflatex -interaction=nonstopmode "$TEX_FILE"

rm -f "$BASE.aux" "$BASE.log" "$BASE.out" "$BASE.toc" "$BASE.synctex.gz" "$BASE.fls" "$BASE.fdb_latexmk"

echo
if command -v pdfinfo >/dev/null 2>&1; then
  PAGES=$(pdfinfo "$BASE.pdf" | awk '/^Pages:/ {print $2}')
  echo "Built: $BASE.pdf ($PAGES pages)"
else
  echo "Built: $BASE.pdf"
fi
