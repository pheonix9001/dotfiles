#!/bin/sh

mkdir ~/.packs
cd ~/.packs
git clone https://aur.archlinux.org/paru.git
cd paru 
makepkg -si

paru -S lemonbar-clicks-git picom-jonaburg-git nordic-darker-theme
