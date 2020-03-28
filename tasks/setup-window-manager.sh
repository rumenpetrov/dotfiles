#!/bin/bash

# This script is part of the main script and it depends on it

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
echo ""

echo "Do you want to continue?"
select CHOICE_RUN in "Yes" "No"; do
    case $CHOICE_RUN in
        Yes ) break;;
        No ) return 0;;
    esac
done

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