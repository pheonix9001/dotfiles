{
  config,
  lib,
  pkgs,
  crane-lib,
  ...
}: {
  imports = [./modules/core.nix ./modules/bspwm.nix ./modules/misc.nix ./modules/kakoune.nix ./modules/lemonbar.nix ./modules/scripts.nix];

  bspwm.enabled = true;
  broot.enabled = true;
  fzf.enabled = true;
  kakoune.enabled = true;
  lemonbar.enabled = true;

  dotfiles-drv = let
    switch-to-config = pkgs.writeShellScriptBin "switch-to-config" config.switch-to-script;
    switch-from-config = pkgs.writeShellScriptBin "switch-from-config" config.switch-from-script;
  in
    pkgs.buildEnv {
      name = "pheonix9001-dotfiles";
      paths = [switch-to-config switch-from-config];
    };

  lemonbar.config = crane-lib.buildPackage {
    src = config/lemonbar;
    cargoToml = config/lemonbar/Cargo.toml;
    doCheck = false;
    cargoArtifacts = crane-lib.buildDepsOnly {
      src = config/lemonbar;
      cargoToml = config/lemonbar/Cargo.toml;
    };
  };

  kakoune.plugins = with pkgs.kakounePlugins; {kak-lsp = kak-lsp;};

  packages.neofetch = pkgs.neofetch;
  packages.zathura = pkgs.zathura;
  packages.imagemagick = pkgs.imagemagick;
  packages.sxiv = pkgs.sxiv;
  packages.lxappearance = pkgs.lxappearance;

  packages.xdotool = pkgs.xdotool;
  packages.xsel = pkgs.xsel;
  packages.xorg_xset = pkgs.xorg.xset;
  packages.xorg_xrandr = pkgs.xorg.xrandr;
  packages.xorg_xsetroot = pkgs.xorg.xsetroot;

  symlinks."~/.bashrc" = ./config/bash/bashrc;
}
