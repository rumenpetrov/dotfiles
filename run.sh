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
  log_task "Backup dot files"
  echo "    TODO"

  # for item in ./files/.*; do
  #   # Ignore the folders
  #   if [ ! -d "$item" ]; then
  #     target="${item##*/}"
  #     path_target="$HOME/$target"

  #     # TODO:
  #     # - Refactor both functions
  #     backup $path_target $target
  #     symlink $path_target $target
  #   fi
  # done
fi

if [[ $wizard_git == "y" ]] || [[ $wizard_git == "Y" ]]; then
  log_task "Setup git"
  source ./tasks/git-setup.sh
fi

log_task "Reload .bashrc file"
source $HOME/.bashrc

echo "👌 Awesome, all set."