#!/usr/bin/env bash
# Download open-access copies of proposal bibliography PDFs.
# Paywalled papers: see references/MANUAL-DOWNLOAD.md
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PAPERS="$ROOT/references/papers"
SUPP="$ROOT/references/supplementary"
mkdir -p "$PAPERS" "$SUPP"

ok() { echo "OK  $1"; }
fail() { echo "FAIL $1"; }

download() {
  local out="$1" url="$2"
  if curl -fsSL --max-time 180 -L -A "Mozilla/5.0 (compatible; FlintSecure/1.0)" \
    -o "$PAPERS/$out" "$url" 2>/dev/null && head -c 5 "$PAPERS/$out" | grep -q '%PDF'; then
    ok "$out"
    return 0
  fi
  rm -f "$PAPERS/$out"
  fail "$out"
  return 1
}

echo "Downloading open-access references into $PAPERS"
echo

download "01-fiu-nepal-annual-report-2023-24.pdf" \
  "https://www.nrb.org.np/contents/uploads/2025/03/FIU-Nepal-Annual-Report-2080.81-202324.pdf" || true

download "02-eckersley-2010-browser-uniqueness.pdf" \
  "https://coveryourtracks.eff.org/static/browser-uniqueness.pdf" || true

download "08-dalpozzolo-2015-calibrating-probability.pdf" \
  "https://dalpozz.github.io/static/pdf/SSCI_calib_final_noCC.pdf" || true

if curl -fsSL --max-time 180 -L -A "Mozilla/5.0" \
  -o "$SUPP/ENISA-countering-sim-swapping.pdf" \
  "https://www.enisa.europa.eu/sites/default/files/publications/ENISA_REPORT-Countering_SIM_Swapping.pdf" 2>/dev/null \
  && head -c 5 "$SUPP/ENISA-countering-sim-swapping.pdf" | grep -q '%PDF'; then
  ok "supplementary/ENISA-countering-sim-swapping.pdf"
else
  fail "supplementary/ENISA-countering-sim-swapping.pdf"
fi

echo
echo "HAL / IEEE / Elsevier papers must be saved manually — see references/MANUAL-DOWNLOAD.md"
echo "Current papers/:"
ls -lh "$PAPERS" 2>/dev/null || true
