{
  config,
  options,
  lib,
  pkgs,
  crane-lib,
  ...
}: {
  options.lemonbar.enabled = lib.mkEnableOption "Lemonbar as status bar";
  options.lemonbar.config = lib.mkOption {
    description = "The derivation of the lemonbar configuration";
    default = crane-lib.buildPackage {
      src = ../config/lemonbar;
      doCheck = false;
      cargoArtifacts = crane-lib.buildDepsOnly {
        src = ../config/lemonbar;
      };
    };

    type = lib.types.package;
  };
}
