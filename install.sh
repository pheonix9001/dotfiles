#!/bin/bash

# environment variables
export INSTALL="pacman -S"
export UPDATE="pacman -Syu"

#update stuff
$UPDATE

# install stuff
$INSTALL neovim
$INSTALL bspwm sxhkd
$INSTALL hsetroot
$INSTALL dmenu skim xdotool fd dex
$INSTALL termite neofetch

mkdir ~/.packs
cd ~/.packs
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg -si
