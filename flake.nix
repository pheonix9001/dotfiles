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

  outputs = inputs@{ self, nixpkgs, flake-utils, kak-lsp, crane, }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        crane-lib = crane.lib.${system};
      in rec {
        lib = nixpkgs.lib // (import ./lib.nix {inherit lib;});
        ysets.pheonix9001 = lib.y_ext (import ./yconfig.nix lib) {
          inherit pkgs;
          deps.crane-lib = crane-lib;
        };
        ysets.default = ysets.pheonix9001;

        packages = let cfg = lib.Y ysets.default;
        in rec {
          dotfiles = cfg.dotfiles-drv;
          lemonbar-conf = cfg.lemonbar.config;
          default = dotfiles;
        };
      });
}
