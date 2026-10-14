#!/usr/bin/env bash
set -euo pipefail

DEST="$HOME/.local/share/antigravity"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Fetching latest download URL..."
PAGE=$(curl -fsSL --compressed "https://antigravity.google/download")

DOWNLOAD_URL=$(printf '%s' "$PAGE" \
  | grep -oE 'https://storage\.googleapis\.com/antigravity-public/antigravity-hub/[0-9]+\.[0-9]+\.[0-9]+-[0-9]+/linux-x64/Antigravity\.tar\.gz' \
  | sort -uV | tail -n 1 || true)

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "Error: Failed to extract download URL." >&2
  exit 1
fi
echo "Found: $DOWNLOAD_URL"

echo "Downloading..."
curl -#fSL "$DOWNLOAD_URL" -o "$TMP_DIR/Antigravity.tar.gz"

# Make sure --strip-components=1 is valid before wiping the install
TOP=$(tar -tzf "$TMP_DIR/Antigravity.tar.gz" | cut -d/ -f1 | sort -u | wc -l)
if [[ "$TOP" -ne 1 ]]; then
  echo "Error: archive has $TOP top-level entries, expected 1." >&2
  exit 1
fi

pkill -x antigravity || true

echo "Extracting to $DEST..."
mkdir -p "$DEST"
rm -rf "${DEST:?}/"*
tar -xzf "$TMP_DIR/Antigravity.tar.gz" -C "$DEST" --strip-components=1
echo "Antigravity updated successfully."
