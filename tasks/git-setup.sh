#!/bin/bash

echo ""

echo -n "> Type in your email address (the one used for your GitHub account): "
read -r email

echo -n "> Type in your full name: "
read -r full_name

echo -n "> Type in your preferred editor(vim or nano): "
read -r editor

if [[ -n "$email" ]]; then
  git config --global --unset-all user.email
  git config --global user.email "$email"
fi

if [[ -n "$full_name" ]]; then
  git config --global --unset-all user.name
  git config --global user.name "$full_name"
fi

if [[ -n "$editor" ]]; then
  git config --global --unset-all core.editor
  git config --global core.editor "$editor"
fi

echo ""
echo "Your new ~/.gitconfig file:"
git config --global --list

echo ""