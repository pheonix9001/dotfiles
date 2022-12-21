{
  config,
  options,
  lib,
  ...
}:
with lib; {
  options.bspwm.enabled = mkEnableOption "Bspwm as window manager";

  config = mkIf config.bspwm.enabled {
    packages.bspwm = true;
    packages.sxhkd = true;
    packages.xprompt = true;
    packages.hsetroot = true;
  };
}
