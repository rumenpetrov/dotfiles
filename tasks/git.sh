#!/bin/bash

# This is part of the main script and it depends on it

function install_dependencies() {
  sudo dnf install git
}

function setup_git {
  local path_to_config_file="~/.gitconfig"

  if [[ ! -f "$(which git)" ]]; then
    echo "git is not found on you system. You have to install it in order to continue?"
    select choice_dependencies in "Yes" "No"; do
        case $choice_dependencies in
            Yes ) install_dependencies break;;
            No ) return;;
        esac
    done
  fi

  echo -n "> Type in your email address (the one used for your GitHub account): "
  read -r input_email

  echo -n "> Type in your full name: "
  read -r input_full_name

  echo "Pick your editor?"
  select editor_choice in "vim" "nano"; do
      case $editor_choice in
          vim ) break;;
          nano ) break;;
      esac
  done

  if [[ -n $input_email ]]; then
    git config --global --unset-all user.email
    git config --global user.email "$input_email"
  fi

  if [[ -n $input_full_name ]]; then
    git config --global --unset-all user.name
    git config --global user.name "$input_full_name"
  fi

  if [[ -n $editor_choice ]]; then
    git config --global --unset-all core.editor
    git config --global core.editor "$editor_choice"
  fi

  echo ""
  echo "Your new $path_to_config_file file:"
  echo "----------"
  git config --global --list
  echo "----------"
}