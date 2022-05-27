#!/bin/bash

# This is part of the main script and it depends on it

function update_gnome_settings {
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['disabled']" &&
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down', '<Control><Super>Right']" &&
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['disabled']" &&
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up', '<Control><Super>Left']" &&
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Shift>Page_Down', '<Super><Shift><Alt>Right', '<Control><Shift><Super>Right']" &&
  gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Shift>Page_Up', '<Super><Shift><Alt>Left', '<Control><Shift><Super>Left']"
}