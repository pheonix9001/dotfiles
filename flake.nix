{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    crane.inputs.nixpkgs.follows = "nixpkgs";
    crane.inputs.flake-utils.follows = "flake-utils";
    nix-std.url = "github:chessai/nix-std";
  };

  outputs = inputs@{ self, nixpkgs, flake-utils, crane, nix-std }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        crane-lib = crane.lib.${system};
      in rec {
        lib = nix-std.lib // (import ./lib.nix { inherit lib; });
        ysets.pheonix9001 = lib.y_ext (import ./yconfig.nix lib) {
          inherit pkgs system;
          deps = { inherit crane-lib; };
        };
        ysets.default = ysets.pheonix9001;
        packages = (lib.Y ysets.default).outputs;
      });
}
