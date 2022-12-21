{
  config,
  options,
  lib,
  ...
}: {
  options.kakoune.enabled = lib.mkEnableOption "Kakoune for text editing";

  config = lib.mkIf config.kakoune.enabled {
    packages.kakoune = true;
    packages.rust-analyzer = true;

    symlinks."~/.config/kak" = ../config/kak;
  };
}
