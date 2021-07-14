#!/bin/bash

# install stuff
doas ./install.sh
./aur.sh

# set symlinks
ln -sf ~/dotfiles/config ~/.config
ln -sf ~/.config/bash/bashrc ~/.bashrc
ln -sf ~/dotfiles/scripts ~/.scripts

# wallpapers!
mkdir -p ~/Pictures/wallpapers
