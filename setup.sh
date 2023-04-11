#!/bin/sh

# Install
switch-from-config \
&& nix profile upgrade '.*' \
|| (echo "-- First run"; nix profile install .#dotfiles)
switch-to-config
