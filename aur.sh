#!/bin/bash

mkdir ~/.packs
cd ~/.packs
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg -si

paru -S lemonbar-clicks-git picom-jonaburg-git
paru -S nerd-fonts-mononoki nordic-darker-theme
paru -S brave-nightly-bin picomc
