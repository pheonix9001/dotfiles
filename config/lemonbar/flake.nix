{
  description = "My lemonbar configuration";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        packages.default = pkgs.rustPlatform.buildRustPackage {
          pname = "controllemonbar";
          version = "0.1.0";
          src = ./.;
          doCheck = false;

          cargoLock = {
            lockFile = ./Cargo.lock;
          };
        };

		devShell = pkgs.mkShell {
		  packages = [];
		};
      }
    );
}
