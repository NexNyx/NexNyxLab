#!/bin/bash
# quickscan.sh domain
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 domain-or-ip"
  exit 1
fi

TARGET="$1"
OUTDIR=~/NexNyxLab/results/${TARGET//\//_}
mkdir -p "$OUTDIR"

echo "[*] Start quickscan for $TARGET -> $OUTDIR"

echo "[*] Headers..."
if curl -Is "https://${TARGET}" > "$OUTDIR/headers.txt" 2>/dev/null; then
  sed -n '1,60p' "$OUTDIR/headers.txt"
else
  curl -Is "http://${TARGET}" | sed -n '1,60p' > "$OUTDIR/headers.txt" || true
fi

# Choose nmap scan type based on privileges
if [ "$(id -u)" -eq 0 ]; then
  NMAP_SCAN_TYPE="-sS -p80,443,22"
else
  NMAP_SCAN_TYPE="-sT -p80,443,22"
fi

echo "[*] Nmap (safe) using $NMAP_SCAN_TYPE..."
nmap $NMAP_SCAN_TYPE -sV -oN "$OUTDIR/nmap.txt" "$TARGET" || true

echo "[*] Nikto scan (safe) - output kan veel lines bevatten..."
# Nikto werkt zonder root; forceer http (nikto has -ssl flag if needed)
nikto -h "http://${TARGET}" -output "$OUTDIR/nikto.txt" || true

echo "[*] Quickscan finished. Results: $OUTDIR"
