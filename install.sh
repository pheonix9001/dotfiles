#!/bin/bash

# environment variables
export INSTALL="pacman -S"
export UPDATE="pacman -Syu"

#update stuff
$UPDATE

# install stuff
$INSTALL neovim alsa-utils
$INSTALL bspwm sxhkd ccls
$INSTALL hsetroot kakoune
$INSTALL dmenu fzf xdotool fd dex
$INSTALL neofetch
