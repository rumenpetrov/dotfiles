#!/usr/bin/env bash
# Grant non-root WebHID (VIA/Launcher) and WebUSB DFU (firmware flashing) access.

set -euo pipefail

VENDOR_ID="${1:-3434}"
RULE_FILE="/etc/udev/rules.d/70-keychron-via.rules"

# 1. Standard Keychron WebHID access (daily keymap/macro config)
# 2. STM32 & Westberry DFU Bootloader access (firmware flashing)
RULE_CONTENT="# Keychron WebHID access
KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"${VENDOR_ID}\", TAG+=\"uaccess\"

# Keychron DFU Bootloaders (STM32 & Westberry) for WebUSB firmware flashing
SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"0483\", ATTRS{idProduct}==\"df11\", TAG+=\"uaccess\"
SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"342d\", ATTRS{idProduct}==\"dfa0\", TAG+=\"uaccess\""

if [[ ! "$VENDOR_ID" =~ ^[0-9a-fA-F]{4}$ ]]; then
    echo "Error: Invalid Vendor ID '${VENDOR_ID}'. Must be a 4-digit hex string." >&2
    exit 1
fi

echo "Configuring Keychron WebHID and DFU bootloader rules..."

if [[ $EUID -ne 0 ]]; then
    echo "$RULE_CONTENT" | sudo tee "$RULE_FILE" > /dev/null
    sudo udevadm control --reload-rules
    sudo udevadm trigger --subsystem-match=hidraw --action=add
    sudo udevadm trigger --subsystem-match=usb --action=add
else
    echo "$RULE_CONTENT" > "$RULE_FILE"
    udevadm control --reload-rules
    udevadm trigger --subsystem-match=hidraw --action=add
    udevadm trigger --subsystem-match=usb --action=add
fi

echo "Rules written to ${RULE_FILE} and udev reloaded."
