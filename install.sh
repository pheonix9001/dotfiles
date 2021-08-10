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
$INSTALL dmenu fzf xdotool fd dex
$INSTALL alacritty neofetch
