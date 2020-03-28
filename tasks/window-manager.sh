#!/bin/bash

# This is part of the main script and it depends on it

function install_dependencies() {
  sudo dnf install sway swayidle swaylock waybar grim slurp wl-clipboard wofi light
}

function setup_WM() {
  local path_to_actual_config_dir="~/.config"
  local path_to_input_config_dir=$2

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
  select choice_run in "Yes" "No"; do
      case $choice_run in
          Yes ) break;;
          No ) return;;
      esac
  done

  install_dependencies

  mkdir -p "$path_to_actual_config_dir/sway/"
  backup "config" "$path_to_actual_config_dir/sway/config"
  symlink "$path_to_input_config_dir/sway/config" "$path_to_actual_config_dir/sway/config"

  mkdir -p "$path_to_actual_config_dir/waybar/"
  backup "config" "$path_to_actual_config_dir/waybar/config"
  symlink "$path_to_input_config_dir/waybar/config" "$path_to_actual_config_dir/waybar/config"
  backup "config" "$path_to_actual_config_dir/waybar/style.css"
  symlink "$path_to_input_config_dir/waybar/style.css" "$path_to_actual_config_dir/waybar/style.css"
}
