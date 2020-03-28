#!/bin/bash

# This script is part of the main script and it depends on it

echo -n "> Type in your email address (the one used for your GitHub account): "
read -r EMAIL

echo -n "> Type in your full name: "
read -r FULL_NAME

echo "Pick your editor?"
select EDITOR_CHOICE in "vim" "nano"; do
    case $EDITOR_CHOICE in
        vim ) break;;
        nano ) break;;
    esac
done

if [[ -n $EMAIL ]]; then
  git config --global --unset-all user.email
  git config --global user.email "$EMAIL"
fi

if [[ -n $FULL_NAME ]]; then
  git config --global --unset-all user.name
  git config --global user.name "$FULL_NAME"
fi

if [[ -n $EDITOR_CHOICE ]]; then
  git config --global --unset-all core.editor
  git config --global core.editor "$EDITOR_CHOICE"
fi

echo ""
echo "Your new ~/.gitconfig file:"
echo "----------"
git config --global --list
echo "----------"

echo ""