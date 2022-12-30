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
      module = nixpkgs.lib.evalModules {modules = [(import ./configuration.nix) {_module.args.pkgs = pkgs;}];};
      conf = module.config;
      pkgs = nixpkgs.legacyPackages.${system};
      crane-lib = crane.lib.${system};

      lemonbar-conf =
        (import ./config/lemonbar {
          inherit nixpkgs crane-lib;
        })
        .lemonbar-config;
      kak-lsp-built = (import ./packages/kak-lsp.nix {inherit nixpkgs crane-lib kak-lsp;}).kak-lsp;

      conf-packages = with nixpkgs; builtins.attrValues conf.packages;
    in rec {
      config.pheonix9001 = import ./configuration.nix;

      packages.default = packages.dotfiles;
      packages.dotfiles = pkgs.buildEnv {
        name = "pheonix9001-dotfiles";
        paths = [packages.switch-to-config packages.switch-from-config lemonbar-conf kak-lsp-built] ++ conf-packages;
      };
      packages.switch-to-config = pkgs.writeShellScriptBin "switch-to-config" conf.switch-to-script;
      packages.switch-from-config = pkgs.writeShellScriptBin "switch-from-config" conf.switch-from-script;
    });
}
