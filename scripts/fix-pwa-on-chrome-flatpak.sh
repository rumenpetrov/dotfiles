#!/bin/bash

APP_DIR="$HOME/.local/share/applications"
echo "Fixing Flatpak PWA desktop files..."

for file in "$APP_DIR"/chrome-*.desktop "$APP_DIR"/com.google.Chrome.flextop.*.desktop; do
    [ -e "$file" ] || continue
    echo "Processing: $(basename "$file")"

    # 1. Fix Wayland window grouping
    sed -i '/^NoDisplay=true/d' "$file"
    sed -i 's/^StartupWMClass=crx_\(.*\)/StartupWMClass=chrome-\1-Default/' "$file"

    # 2. Extract pure icon name (stripping the broken sandbox path and .png)
    RAW_ICON=$(grep "^Icon=" "$file" | cut -d= -f2 | awk -F'/' '{print $NF}' | sed 's/\.png$//')

    # 3. Find the highest resolution host path
    HOST_ICON_PATH=""
    for res in 512x512 256x256 128x128 64x64; do
        target="$HOME/.local/share/icons/hicolor/$res/apps/${RAW_ICON}.png"
        if [ -f "$target" ]; then
            HOST_ICON_PATH="$target"
            break
        fi
    done

    # 4. Inject the working host path
    if [ -n "$HOST_ICON_PATH" ]; then
        # Use | as sed delimiter to avoid conflicts with slashes in the file path
        sed -i "s|^Icon=.*|Icon=$HOST_ICON_PATH|" "$file"
        echo "  -> Icon fixed: $HOST_ICON_PATH"
    else
        echo "  -> Failed: Could not find host icon for $RAW_ICON"
    fi
done

update-desktop-database "$APP_DIR"
echo "Done."
