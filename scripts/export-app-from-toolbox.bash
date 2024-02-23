#!/bin/bash

echo
echo -e "Description: Export a .desktop file from application installed in a toolbox."
echo -e "Example: ./export-app-from-toolbox.bash system-f39 sublime_text.desktop"
echo
echo -e "Dependencies:"
echo -e "- toolbox"
echo

echo "Do you want to proceed?"
select choice_start in "Yes" "No"; do
  case $choice_start in
    Yes ) clear; break;;
    No ) exit 1
  esac
done

toolbox_name=$1
desktop_file_name=$2

if [ -z "$toolbox_name" ]; then
  echo
  echo -e "Please specify toolbox name as first argument."
  echo

  toolbox list

  exit 1
fi

if [ -z "$desktop_file_name" ]; then
  echo
  echo -e "Please specify desktop file name as second argument."
  echo

  toolbox run --container "$toolbox_name" ls -la /usr/share/applications/

  exit 1
fi

toolbox run --container "$toolbox_name" cp "/usr/share/applications/$desktop_file_name" "$HOME/.local/share/applications/$desktop_file_name"

echo -e "Done."
echo -e "Make sure you update the exec command."
echo -e "E.g. 'toolbox run --container system-f39 /opt/sublime_text/sublime_text %F'"