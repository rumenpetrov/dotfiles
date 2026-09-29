#!/bin/bash

# This is part of the main script and it depends on it

function setup-bash {
  path_to_input_files=$1

  log_subtask "Customizing .bashrc"

  # Explicitly configure .bashrc
  if ! grep -q "source $path_to_input_files/.bashrc" "$HOME/.bashrc"; then
    echo -e "\n# Load shared dotfiles configuration" >> "$HOME/.bashrc"
    echo "source $path_to_input_files/.bashrc" >> "$HOME/.bashrc"
    log_subtask_success "Injected source link into ~/.bashrc"
  else
    log_subtask_info "Skipping * ~/.bashrc already sources the dotfiles."
  fi

  log_subtask "Reload bash configuration."
  log_subtask_info "Make sure you open new window or reload the configuration of the current one.(Example: . ~/.bashrc)"
}
