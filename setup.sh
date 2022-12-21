#!/bin/sh

# Install
nix profile install .#dotfiles
switch-to-config
