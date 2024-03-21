#!/bin/bash

# This is part of the main script and it depends on it

function reset_some_gnome_settings {
  gsettings reset org.gnome.mutter.keybindings toggle-tiled-left
  gsettings reset org.gnome.mutter.keybindings toggle-tiled-right
  gsettings reset org.gnome.desktop.wm.keybindings maximize
}