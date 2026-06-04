#!/usr/bin/env bash
# Generate PDF diagrams from PlantUML sources in figures/uml/src/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$ROOT/figures/uml/src"
OUT="$ROOT/figures/uml"
JAR="$ROOT/tools/plantuml.jar"
PLANTUML_VERSION="1.2025.10"
JAR_URL="https://github.com/plantuml/plantuml/releases/download/v${PLANTUML_VERSION}/plantuml-${PLANTUML_VERSION}.jar"

if [[ ! -d "$SRC" ]]; then
  echo "error: missing $SRC" >&2
  exit 1
fi

verify_outputs() {
  local ok=1
  for f in "$OUT"/*.pdf; do
    [[ -f "$f" ]] || continue
    if [[ ! -s "$f" ]] || [[ "$(wc -c < "$f")" -lt 500 ]]; then
      echo "error: invalid PDF $(basename "$f") — run: brew install plantuml graphviz" >&2
      ok=0
    fi
  done
  if [[ "$ok" -eq 0 ]]; then
    exit 1
  fi
  echo "Done. PDFs in figures/uml/"
}

run_plantuml() {
  local cmd=("$@")
  for f in "$SRC"/*.puml; do
    [[ -f "$f" ]] || continue
    echo "  $(basename "$f")"
    # Run from SRC so -o ../ writes to figures/uml/ (not nested paths)
    (cd "$SRC" && "${cmd[@]}" -tpdf -o ".." "$(basename "$f")")
  done
}

if command -v plantuml >/dev/null 2>&1; then
  echo "Building UML PDFs (system plantuml)..."
  if ! command -v dot >/dev/null 2>&1; then
    echo "warning: graphviz (dot) not found — install with: brew install graphviz" >&2
  fi
  run_plantuml plantuml
  verify_outputs
  exit 0
fi

if ! command -v java >/dev/null 2>&1; then
  echo "error: install Java or PlantUML (brew install plantuml graphviz)" >&2
  exit 1
fi

if [[ ! -f "$JAR" ]]; then
  echo "Downloading PlantUML ${PLANTUML_VERSION}..."
  mkdir -p "$ROOT/tools"
  curl -fsSL -o "$JAR" "$JAR_URL"
fi

echo "Building UML PDFs (java -jar plantuml)..."
echo "note: for reliable PDF output, prefer: brew install plantuml graphviz" >&2
run_plantuml java -Djava.awt.headless=true -jar "$JAR"
verify_outputs
