#!/bin/sh

# copy directories
cp -r config ~/.config
ln -sf ~/.config/bash/bashrc ~/.bashrc
cp -r scripts ~/.scripts
