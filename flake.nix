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

  outputs = inputs@{
    self,
    nixpkgs,
    flake-utils,
    kak-lsp,
    crane,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      module = nixpkgs.lib.evalModules { modules = [(import ./configuration.nix)]; };
      conf = module.config;
      pkgs = nixpkgs.legacyPackages.${system};
      crane-lib = crane.lib.${system};

      lemonbar-conf =
        (import ./config/lemonbar {
          inherit nixpkgs crane-lib;
        })
        .lemonbar-config;
      kak-lsp-built = (import ./packages/kak-lsp.nix { inherit nixpkgs crane-lib kak-lsp; }).kak-lsp;

      conf-packages = nixpkgs.lib.mapAttrsToList (n: v: pkgs.${n}) (nixpkgs.lib.filterAttrs (n: v: v) conf.packages);
      env-packages = with pkgs; conf-packages ++ [
        # Editor
        kakoune
        rust-analyzer

        # Desktop
        lemonbar-xft
        imagemagick

        # Fuzzy searching
        fzf
        fd
        broot

        # xorg
        xdotool
        xsel
        xorg.xset
        xorg.xrandr
        xorg.xsetroot

        # other
        zathura

        neofetch
        imagemagick
      ];
    in rec {
	  out-config = module;
      packages.default = packages.dotfiles;
      packages.dotfiles = pkgs.buildEnv {
        name = "pheonix9001-dotfiles";
        paths = [packages.configs lemonbar-conf kak-lsp-built] ++ env-packages;
      };
      packages.configs = pkgs.stdenv.mkDerivation {
        name = "pheonix9001-configs";
        src = self;
        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;

        installPhase = ''
          export HOME=$out/${conf.home}

          mkdir -p $HOME
          cp -r config ~/.config
          ln -sf ~/.config/bash/bashrc ~/.bashrc
          cp -r scripts ~/.scripts
        '';
      };
    });
}
