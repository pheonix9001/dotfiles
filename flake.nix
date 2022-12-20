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

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    kak-lsp,
    crane,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      home = "/home/asdf";
      pkgs = nixpkgs.legacyPackages.${system};
      crane-lib = crane.lib.${system};

      lemonbar-conf =
        (import ./config/lemonbar {
          inherit nixpkgs crane-lib;
        })
        .lemonbar-config;
      kak-lsp-built = (import ./packages/kak-lsp.nix { inherit nixpkgs crane-lib kak-lsp; }).kak-lsp;

      env-packages = with pkgs; [
        # Editor
        kakoune
        rust-analyzer

        # Desktop
        sxhkd
        bspwm
        xprompt
        hsetroot
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
      ];
    in rec {
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
          export HOME=$out/${home}

          mkdir -p $HOME
          cp -r config ~/.config
          ln -sf ~/.config/bash/bashrc ~/.bashrc
          cp -r scripts ~/.scripts
        '';
      };
    });
}
