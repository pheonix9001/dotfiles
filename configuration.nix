{
  config,
  lib,
  options,
  pkgs,
  crane-lib,
  ...
}: {
  imports = [./modules/core.nix ./modules/bspwm.nix ./modules/misc.nix ./modules/kakoune.nix ./modules/lemonbar.nix];

  bspwm.enabled = true;
  broot.enabled = true;
  fzf.enabled = true;
  kakoune.enabled = true;
  lemonbar.enabled = true;
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

  packages.xdotool = pkgs.xdotool;
  packages.xsel = pkgs.xsel;
  packages.xorg_xset = pkgs.xorg.xset;
  packages.xorg_xrandr = pkgs.xorg.xrandr;
  packages.xorg_xsetroot = pkgs.xorg.xsetroot;

  symlinks."~/.bashrc" = ./config/bash/bashrc;
  symlinks."~/.scripts" = ./scripts;
}
