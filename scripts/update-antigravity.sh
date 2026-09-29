#!/usr/bin/env bash
set -euo pipefail

DEST="$HOME/.local/share/antigravity"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Fetching latest download URL..."

DOWNLOAD_URL=$(curl -fsSL --compressed "https://antigravity.google/download" \
  | grep -m 1 -oE 'https://storage\.googleapis\.com/antigravity-public/[^"]+linux-x64/Antigravity\.tar\.gz' || true)

if [[ -z "$DOWNLOAD_URL" ]]; then
  echo "Error: Failed to extract download URL." >&2
  exit 1
fi

echo "Found: $DOWNLOAD_URL"

pkill -x antigravity || true

echo "Downloading..."
curl -#fSL "$DOWNLOAD_URL" -o "$TMP_DIR/Antigravity.tar.gz"

echo "Extracting to $DEST..."
mkdir -p "$DEST"
rm -rf "${DEST:?}/"*
tar -xzf "$TMP_DIR/Antigravity.tar.gz" -C "$DEST" --strip-components=1

echo "Antigravity updated successfully."
