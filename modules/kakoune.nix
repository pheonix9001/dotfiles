{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  options.kakoune.enabled = lib.mkEnableOption "Kakoune for text editing";

  config = lib.mkIf config.kakoune.enabled {
    packages.kakoune = pkgs.kakoune;
    packages.rust-analyzer = pkgs.rust-analyzer;
    packages.rustfmt = pkgs.rustfmt;

    symlinks."~/.config/kak" = ../config/kak;
  };
}
