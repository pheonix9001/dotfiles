{
  description = "My dotfiles";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";

    kak-lsp.url = "github:kak-lsp/kak-lsp";
    kak-lsp.flake = false;
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    kak-lsp,
    crane,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      crane-lib = crane.lib.${system};
    in rec {
      modules.pheonix9001 = import ./configuration.nix;

      packages = let
        cfg =
          (nixpkgs.lib.evalModules {
            modules = [
              modules.pheonix9001
              {
                _module.args = {
                  pkgs = pkgs;
                  crane-lib = crane-lib;
                };
              }
            ];
          })
          .config;
      in rec {
        dotfiles = cfg.dotfiles-drv;
        default = dotfiles;
        lemonbar-conf = cfg.lemonbar.config;
      };
    });
}
