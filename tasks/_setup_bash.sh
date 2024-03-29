#!/bin/bash

# This is part of the main script and it depends on it

function setup-bash {
  path_to_input_files=$1

  # Loop files that start with dot
  for current_file_or_folder in "$path_to_input_files"/.*; do
    # Ignore the folders
    if [ ! -d "$current_file_or_folder" ] && [ -e "$current_file_or_folder" ]; then
      file_name="${current_file_or_folder##*/}"

      backup "$file_name" "$HOME/$file_name"
      symlink "$file_name" "$path_to_input_files/$file_name" "$HOME/$file_name"
    fi
  done

  # Loop the rest of the files
  for current_file_or_folder in "$path_to_input_files"/*; do
    # Ignore the folders
    if [ ! -d "$current_file_or_folder" ] && [ -e "$current_file_or_folder" ]; then
      file_name="${current_file_or_folder##*/}"

      backup "$file_name" "$HOME/$file_name"
      symlink "$file_name" "$path_to_input_files/$file_name" "$HOME/$file_name"
    fi
  done

  log_subtask "Reload bash configuration."
  log_subtask_info "Make sure you open new window or reload the configuration of the current one.(Example: . ~/.bashrc)"
}