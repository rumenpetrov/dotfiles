#!/bin/bash

# This is part of the main script and it depends on it

function install_just {
  curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to "$HOME/.local/bin/"
}