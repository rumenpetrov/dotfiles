#!/bin/bash

SPACER="    "

#
# Usage: log_task <message>
# Description: Custom task log.
#
function log_task() {
  echo "🌀 $1"
}

#
# Usage: log_subtask <message>
# Description: Custom subtask log.
#
function log_subtask() {
  echo "✳️  $1"
}

#
# Usage: log_subtask_success
# Description: Log subtask that is completed.
#
function log_subtask_success() {
  echo "$SPACER✔ Completed * $1"
}

#
# Usage: log_subtask_info <message>
# Description: Log subtask information message.
#
function log_subtask_info() {
  echo "$SPACER✧ $1"
}

#
# Usage: log_subtask_error
# Description: Log subtask that is failed.
#
function log_subtask_error() {
  echo "$SPACER✘ Failed * $1"
}

#
# Usage: backup <file_name>
# Description: Check if the file exists and backup it.
#
function backup() {
  file_name=$1
  path_source="$HOME/$1"
  path_destination="$path_source.backup.$(date +%d-%m-%Y-%H-%M)"

  log_subtask "Backup file $file_name"

  # Does the file already exist?
  if [ -e "$path_source" ]
    then
      # Is it a symlink?
      if [ ! -L "$path_source" ]
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

#
# Usage: symlink <file_name>
# Description: Check if the file exists and replace it with a symlink.
#
function symlink() {
  file_name=$1
  path_source="$HOME/dotfiles/files/$1"
  path_destination="$HOME/$1"

  log_subtask "Symlinking file $file_name"

  # Does the file already exist?
  if [ ! -e "$path_destination" ]
    then
      # Is it a symlink?
      if [ ! -L "$path_destination" ]
        then
          log_subtask_success
          ln -s $path_source $path_destination
        else
          log_subtask_info "Skipping * The file is symlink!"
      fi
    else
      log_subtask_info "Skipping * The file already exists!"
  fi
}
