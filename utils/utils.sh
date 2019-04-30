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
  echo "✳️ $1"
}

#
# Usage: log_subtask_success
# Description: Log subtask that is completed.
#
function log_subtask_success() {
  echo "$SPACER✔ Completed."
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
  echo "$SPACER✘ Failed."
}

#
# Usage: backup <path> <filename>
# Description: Check if the file exists and backup it.
#
function backup() {
  path_source=$1
  filename=$2
  path_destination="$path_source.backup.$(date +%d-%m-%Y-%H-%M)"

  log_subtask "Backup $filename"

  # Does the file already exist?
  if [ -e "$path_source" ]
    then

      # As a pure file?
      if [ ! -L "$path_source" ]
        then
          mv "$path_source" $path_destination
          log_subtask_info "Moved your old $path_source file to $path_destination"
          log_subtask_success
        else
          log_subtask_info "There is not file named ${filename##*/} in your home directory."
          log_subtask_error
      fi
    else
      log_subtask_info "There is not file named ${filename##*/} in your home directory."
      log_subtask_error
  fi
}

#
# Usage: symlink <path> <filename>
# Description: Check if the file exists and make a symlink to it.
#
function symlink() {
  path_source=$1
  filename=$2

  # Does the file already exist?
  if [ ! -e "$path_source" ]; then
    # As a pure file?
    if [ ! -L "$path_source" ]; then
      log_subtask "Symlinking $filename"
      printf "    "
      ln -s "$PWD/$filename" "$path_source"
    fi
  fi
}