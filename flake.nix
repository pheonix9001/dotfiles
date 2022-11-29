{
  description = "My dotfiles";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    controllemonbar.url = "path:config/lemonbar";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    controllemonbar,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      lemonbar-conf = controllemonbar.packages.${system};
      home = "/home/asdf";
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

        # Fuzzy searching
        fzf
        fd

        # xorg
        xdotool
        xsel
        xorg.xset
        xorg.xrandr
        xorg.xsetroot

        neofetch
      ];
    in rec {
      packages.default = packages.dotfiles;
      packages.dotfiles = pkgs.buildEnv {
        name = "pheonix9001-dotfiles";
        paths = [packages.configs lemonbar-conf.default] ++ env-packages;
      };
      packages.configs = pkgs.stdenv.mkDerivation {
        name = "pheonix9001-configs";
        src = self;
        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;

        nativeBuildInputs = [pkgs.hello];
        installPhase = ''
          export HOME=$out/${home}

          mkdir -p ~
          source ./install.sh
        '';
      };
    });
}
