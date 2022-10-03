#!/bin/sh

# install stuff
sudo ./install.sh
./aur.sh

# set symlinks
ln -sf ~/dotfiles/config ~/.config
ln -sf ~/.config/bash/bashrc ~/.bashrc
ln -sf ~/dotfiles/scripts ~/.scripts

# compile controllemonbar
cd ~/.config/lemonbar
cargo build --release

# wallpapers
mkdir -p ~/Pictures/wallpapers
