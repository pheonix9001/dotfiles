{
  config,
  lib,
  options,
  ...
}: {
  imports = [./modules/core.nix ./modules/bspwm.nix ./modules/extras.nix ./modules/kakoune.nix];

  bspwm.enabled = true;
  broot.enabled = true;
  fzf.enabled = true;
  kakoune.enabled = true;

  packages.neofetch = true;
  packages.zathura = true;

  symlinks."~/.bashrc" = ./config/bash/bashrc;
  symlinks."~/.scripts" = ./scripts;
}
