#!/bin/bash

echo ""

echo "The script will install the following packages: "
echo "- sway"
echo "- swayidle"
echo "- swaylock"
echo "- waybar"
echo "- grim"
echo "- slurp"
echo "- wl-clipboard"
echo "- wofi"
echo "- light"
echo "- dunst"
echo -n "Do you want to continue? [y/n]: "
read -r confirmInstall

if [[ $confirmInstall != "y" ]] && [[ $confirmInstall != "Y" ]]; then
  exit 0
fi

sudo dnf install sway swayidle swaylock waybar grim slurp wl-clipboard wofi light

mkdir -p "$HOME/.config/sway/"
backup "config" "$HOME/.config/sway/config"
symlink "$HOME/dotfiles/files/.config/sway/config" "$HOME/.config/sway/config"

mkdir -p "$HOME/.config/waybar/"
backup "config" "$HOME/.config/waybar/config"
symlink "$HOME/dotfiles/files/.config/waybar/config" "$HOME/.config/waybar/config"
backup "config" "$HOME/.config/waybar/style.css"
symlink "$HOME/dotfiles/files/.config/waybar/style.css" "$HOME/.config/waybar/style.css"

echo ""