{
  config,
  options,
  lib,
  ...
}: {
  options.kakoune.enabled = lib.mkEnableOption "Kakoune for text editing";

  config = {
    packages.kakoune = config.kakoune.enabled;
    packages.rust-analyzer = config.kakoune.enabled;
  };
}
