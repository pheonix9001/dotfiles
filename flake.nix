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
      packages.default = packages.dotfiles;

      modules.pheonix9001 = import ./configuration.nix;
      configs.pheonix9001 = (nixpkgs.lib.evalModules {
        modules = [
          modules.pheonix9001
          {
            _module.args = {
              pkgs = pkgs;
              crane-lib = crane-lib;
            };
          }
        ];
      }).config;
      configs.default = configs.pheonix9001;

      packages.dotfiles = pkgs.buildEnv {
        name = "pheonix9001-dotfiles";
        paths = [packages.switch-to-config packages.switch-from-config] ++ (builtins.attrValues configs.default.packages);
      };
      packages.lemonbar-conf = configs.default.lemonbar.config;

      packages.switch-to-config = pkgs.writeShellScriptBin "switch-to-config" configs.default.switch-to-script;
      packages.switch-from-config = pkgs.writeShellScriptBin "switch-from-config" configs.default.switch-from-script;
    });
}
