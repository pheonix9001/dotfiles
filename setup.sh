#!/bin/sh

# Install
# nix profile install .#dotfiles

# symlink
for dir in $(ls -A ~/.nix-profile/$HOME)
do
  fulldir=~/.nix-profile/$HOME/$dir
  ln -sf $fulldir "~/$dir"
  echo $fulldir "<-" $dir
done
