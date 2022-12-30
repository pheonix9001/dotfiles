{
  config,
  lib,
  options,
  pkgs,
  ...
}: {
  imports = [./modules/core.nix ./modules/bspwm.nix ./modules/misc.nix ./modules/kakoune.nix];

  bspwm.enabled = true;
  broot.enabled = true;
  fzf.enabled = true;
  kakoune.enabled = true;

  packages.neofetch = pkgs.neofetch;
  packages.zathura = pkgs.zathura;
  packages.imagemagick = pkgs.imagemagick;
  packages.lemonbar-xft = pkgs.lemonbar-xft;

  packages.xdotool = pkgs.xdotool;
  packages.xsel = pkgs.xsel;
  packages.xorg_xset = pkgs.xorg.xset;
  packages.xorg_xrandr = pkgs.xorg.xrandr;
  packages.xorg_xsetroot = pkgs.xorg.xsetroot;

  symlinks."~/.bashrc" = ./config/bash/bashrc;
  symlinks."~/.scripts" = ./scripts;
}
