{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  options.kakoune.enabled = lib.mkEnableOption "Kakoune for text editing";
  options.kakoune.plugins = lib.mkOption {
    description = "Plugins used by kakoune";
    default = {};
    type = lib.types.attrsOf lib.types.package;
  };

  config = lib.mkIf config.kakoune.enabled {
    packages.kakoune = pkgs.kakoune.override {
      plugins = builtins.attrValues config.kakoune.plugins;
    };
    packages.rust-analyzer = pkgs.rust-analyzer;
    packages.rustfmt = pkgs.rustfmt;

    symlinks."~/.config/kak" = ../config/kak;
  };
}
