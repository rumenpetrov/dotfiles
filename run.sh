#!/bin/bash

# exit when a command fails
set -o errexit
# exit when undeclared variable is used
# set -o nounset
# trace what gets executed
# set -o xtrace

##
# Define utility functions
##
text_indentation="  "

# Usage: log_task <message>
# Description: Custom task log.
function log_task() {
  echo "🌀 $1"
}

# Usage: log_subtask <message>
# Description: Custom subtask log.
function log_subtask() {
  echo "$text_indentation✳️  $1"
}

# Usage: log_subtask_success
# Description: Log subtask that is completed.
function log_subtask_success() {
  MSG="${1:""}"
  echo "$text_indentation$text_indentation✔ Completed * $MSG"
}

# Usage: log_subtask_info <message>
# Description: Log subtask information message.
function log_subtask_info() {
  echo "$text_indentation$text_indentation✧ $1"
}

# Usage: log_subtask_error
# Description: Log subtask that is failed.
function log_subtask_error() {
  echo "$text_indentation$text_indentation✘ Failed * $1"
}

# Usage: backup <file_name>
# Description: Check if the file exists and backup it.
# IMPORTANT: Backup only real files, NOT symlinks
function backup() {
  local file_name=$1
  local path_source=$2
  local path_destination="$path_source.backup.$(date +%d-%m-%Y--%H-%M-%S)"

  log_subtask "Backup file $file_name"

  # Does the file already exist?
  if [[ -f $path_source ]]
    then
      # Is it a symlink?
      if [[ ! -L $path_source ]]
        then
          mv "$path_source" $path_destination
          log_subtask_success "Moved your old $path_source file to $path_destination"
        else
          log_subtask_info "Delete file ${file_name##*/}, because it exists as a symlink in your home directory."
          rm -rf $path_source
      fi
    else
      log_subtask_info "Skipping * There is not file named ${file_name##*/} in your home directory."
  fi
}

# Usage: symlink <file_name>
# Description: Check if the file exists and replace it with a symlink.
function symlinkByName() {
  local file_name=$1
  local path_source=$2
  local path_destination=$3

  log_subtask "Symlinking file $file_name"

  # Does the file already exist?
  if [[ ! -f $path_destination ]]
    then
      # Is it a symlink?
      if [[ ! -L $path_destination ]]
        then
          log_subtask_success
          ln -s $path_source $path_destination
        else
          log_subtask_info "Skipping * The file is a symlink!"
      fi
    else
      log_subtask_info "Skipping * The file already exists!"
  fi
}

# Usage: symlink <path_to_source, path_to_destination>
# Description: Check if the file exists and replace it with a symlink.
function symlink() {
  local path_source=$1
  local path_destination=$2

  log_subtask "Create symlink"

  # Does the file already exist?
  if [[ ! -f $path_destination ]]
    then
      # Is it a symlink?
      if [[ ! -L $path_destination ]]
        then
          log_subtask_success
          ln -s $path_source $path_destination
        else
          log_subtask_info "Skipping * The file is a symlink!"
      fi
    else
      log_subtask_info "Skipping * The file already exists!"
  fi
}

##
# Begin script
##
root_dir="$HOME/os-bootstrap"

echo ""
echo "******************************************************************************************"
echo "# OS bootstrap"
echo "# The script is based on Fedora and using \"dnf\" as a package manager."
echo "******************************************************************************************"
echo ""

echo "Do you want to proceed?"
select choice_run in "Yes" "No"; do
    case $choice_run in
        Yes ) break;;
        No ) exit;;
    esac
done

if [[ $choice_run == "Yes" ]]; then
  clear
fi

echo "Do you want to modify the files from your home folder?"
select choice_home_files in "Yes" "No"; do
    case $choice_home_files in
        Yes ) break;;
        No ) break;;
    esac
done

echo "Do you want to configure git?"
select choice_git in "Yes" "No"; do
    case $choice_git in
        Yes ) break;;
        No ) break;;
    esac
done

echo "Do you want to setup window manager?"
select choice_wm in "Yes" "No"; do
    case $choice_wm in
        Yes ) break;;
        No ) break;;
    esac
done

clear

# Loop through all files in /files folder, backup them if they exist in home directory and symlink the new onces.
if [[ $choice_home_files == "Yes" ]]; then
  log_task "Backup dot files and replace them with symlinks to the new files."
  source $root_dir/tasks/shell-config.sh
  setup_shell $root_dir/files/shell
  echo ""
fi

if [[ $choice_git == "Yes" ]]; then
  log_task "Setup git"
  source $root_dir/tasks/git.sh
  setup_git
  echo ""
fi

if [[ $choice_wm == "Yes" ]]; then
  log_task "Setup window manager"
  source $root_dir/tasks/window-manager.sh
  setup_WM "$root_dir/files/.config"
  echo ""
fi

echo "👌 Awesome, all set."
echo ""
