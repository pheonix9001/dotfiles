{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.bspwm.enabled = mkEnableOption "Bspwm as window manager";

  config = mkIf config.bspwm.enabled {
    packages.bspwm = pkgs.bspwm;
    packages.sxhkd = pkgs.sxhkd;
    packages.xprompt = pkgs.xprompt;
    packages.hsetroot = pkgs.hsetroot;

    symlinks."~/.config/bspwm" = ../config/bspwm;
  };
}
