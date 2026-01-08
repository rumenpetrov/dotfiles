#!/bin/bash

# Define paths
USER_MONITORS="$HOME/.config/monitors.xml"
GDM_MONITORS="/var/lib/gdm/.config/monitors.xml"
GDM_CONFIG_DIR="/var/lib/gdm/.config"

# Check if the source file exists
if [ ! -f "$USER_MONITORS" ]; then
    echo "Error: No monitor configuration found at $USER_MONITORS"
    echo "Please configure your displays in Settings > Displays first."
    exit 1
fi

echo "Copying display configuration to GDM..."

# Ensure the GDM config directory exists
sudo mkdir -p "$GDM_CONFIG_DIR"

# Copy the file
sudo cp "$USER_MONITORS" "$GDM_MONITORS"

# Set correct ownership so GDM can read it
sudo chown gdm:gdm "$GDM_MONITORS"

echo "Done! The login screen should now match your current layout."