{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  imports = [./core.nix];

  options.broot.enabled = mkEnableOption "Broot for fuzzy searching";
  options.fzf.enabled = mkEnableOption "Fzf for fuzzy searching";

  config = mkMerge [
    (mkIf config.broot.enabled {
      packages.broot = pkgs.broot;
      symlinks."~/.config/broot" = ../config/broot;
    })
    (mkIf config.fzf.enabled {
      packages.fd = pkgs.fd;
      packages.fzf = pkgs.fzf;
    })
  ];
}
