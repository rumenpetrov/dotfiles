#!/bin/bash

# Import utility functions
source $HOME/dotfiles/utils/utils.sh

echo -n "Do you want to proceed? [y/n]: "
read -r wizard_start

if [[ $wizard_start != "y" ]] && [[ $wizard_start != "Y" ]]; then
  return 0
fi

echo -n "Do you want to modify the files from your home folder? [y/n]: "
read -r wizard_home_files

echo -n "Do you want to setup git? [y/n]: "
read -r wizard_git

echo -n "Do you want to setup window manager? [y/n]: "
read -r wizard_wm

clear

# Loop through all files in /files folder, backup them if they exist in home directory and symlink the new onces.
if [[ $wizard_home_files == "y" ]] || [[ $wizard_home_files == "Y" ]]; then
  log_task "Backup dot files and replace them with symlinks to the new files."

  # Loop files that start with dot
  for path_new_file in $HOME/dotfiles/files/shell/.*; do
    # Ignore the folders
    if [ ! -d "$path_new_file" ] && [ -e "$path_new_file" ]; then
      file_name="${path_new_file##*/}"

      backup $file_name "$HOME/$file_name"
      symlinkByName $file_name "$HOME/dotfiles/files/shell/$file_name" "$HOME/$file_name"
    fi
  done

  # Loop the rest of the files
  for path_new_file in $HOME/dotfiles/files/shell/*; do
    # Ignore the folders
    if [ ! -d "$path_new_file" ] && [ -e "$path_new_file" ]; then
      file_name="${path_new_file##*/}"

      backup $file_name "$HOME/$file_name"
      symlinkByName $file_name "$HOME/dotfiles/files/shell/$file_name" "$HOME/$file_name"
    fi
  done

  log_task "Reload .profile and .bashrc files"
  # source $HOME/.profile
  source $HOME/.bashrc
fi

if [[ $wizard_git == "y" ]] || [[ $wizard_git == "Y" ]]; then
  log_task "Setup git"
  source $HOME/dotfiles/tasks/git-setup.sh
fi

if [[ $wizard_wm == "y" ]] || [[ $wizard_wm == "Y" ]]; then
  log_task "Setup window manager"
  source $HOME/dotfiles/tasks/setup-window-manager.sh
fi

echo "👌 Awesome, all set."