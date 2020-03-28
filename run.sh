#!/bin/bash

# exit when a command fails
set -o errexit
# exit when undeclared variable is used
# set -o nounset
# trace what gets executed
# set -o xtrace

# Import utility functions
source $HOME/dotfiles/utils/utils.sh

echo "Do you want to proceed?"
select CHOICE_RUN in "Yes" "No"; do
    case $CHOICE_RUN in
        Yes ) break;;
        No ) exit;;
    esac
done

if [[ $CHOICE_RUN == "Yes" ]]; then
  clear
fi

echo "Do you want to modify the files from your home folder?"
select CHOICE_HOME_FILES in "Yes" "No"; do
    case $CHOICE_HOME_FILES in
        Yes ) break;;
        No ) break;;
    esac
done

echo "Do you want to configure git?"
select CHOICE_GIT in "Yes" "No"; do
    case $CHOICE_GIT in
        Yes ) break;;
        No ) break;;
    esac
done

echo "Do you want to setup window manager?"
select CHOICE_WM in "Yes" "No"; do
    case $CHOICE_WM in
        Yes ) break;;
        No ) break;;
    esac
done

clear

# Loop through all files in /files folder, backup them if they exist in home directory and symlink the new onces.
if [[ $CHOICE_HOME_FILES == "Yes" ]]; then
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

  log_subtask "Reload .profile and .bashrc files"
  # source $HOME/.profile
  source $HOME/.bashrc
  echo ""
fi

if [[ $CHOICE_GIT == "Yes" ]]; then
  log_task "Setup git"
  source $HOME/dotfiles/tasks/git-setup.sh
fi

if [[ $CHOICE_WM == "Yes" ]]; then
  log_task "Setup window manager"
  source $HOME/dotfiles/tasks/setup-window-manager.sh
fi

echo "👌 Awesome, all set."