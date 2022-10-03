#!/bin/bash

INSTALL="pacman -S"
UPDATE="pacman -Syu"

#update stuff
$UPDATE

# install stuff
$INSTALL neovim
$INSTALL bspwm sxhkd hsetroot
$INSTALL dmenu fzf xdotool fd
$INSTALL neofetch
