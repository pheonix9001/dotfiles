{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  options.lemonbar.enabled = lib.mkEnableOption "Lemonbar as status bar";
  options.lemonbar.config = lib.mkOption {
    description = "The derivation of the lemonbar configuration";
    type = lib.types.package;
  };

  config = lib.mkIf config.lemonbar.enabled {
    packages.lemonbar = pkgs.lemonbar-xft.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [config.lemonbar.config];
    });
    packages.lemonbar-conf = config.lemonbar.config;
  };
}
