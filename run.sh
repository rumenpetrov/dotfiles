#!/bin/bash

# Import utility functions
source ./utils/utils.sh

echo -n "Do you want to proceed? [y/n]: "
read -r wizard_start

if [[ $wizard_start != "y" ]] && [[ $wizard_start != "Y" ]]; then
  return 0
fi

echo -n "Do you want to backup your dot files and customize them? [y/n]: "
read -r wizard_backup

echo -n "Do you want to setup git? [y/n]: "
read -r wizard_git

clear

# Loop through all files in /files folder, backup them if they exist in home directory and symlink the new onces.
if [[ $wizard_backup == "y" ]] || [[ $wizard_backup == "Y" ]]; then
  log_task "Backup dot files and replace them with symlinks to the new files."

  # Loop files that start with dot
  for path_new_file in $HOME/dotfiles/files/.*; do
    # Ignore the folders
    if [ ! -d "$path_new_file" ] && [ -e "$path_new_file" ]; then
      file_name="${path_new_file##*/}"

      backup $file_name
      symlink $file_name
    fi
  done

  # Loop the rest of the files
  for path_new_file in $HOME/dotfiles/files/*; do
    # Ignore the folders
    if [ ! -d "$path_new_file" ] && [ -e "$path_new_file" ]; then
      file_name="${path_new_file##*/}"

      backup $file_name
      symlink $file_name
    fi
  done
fi

if [[ $wizard_git == "y" ]] || [[ $wizard_git == "Y" ]]; then
  log_task "Setup git"
  source ./tasks/git-setup.sh
fi

log_task "Reload .profile and .bashrc files"
source $HOME/.profile
source $HOME/.bashrc

echo "👌 Awesome, all set."