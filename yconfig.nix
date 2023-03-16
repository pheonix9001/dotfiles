l:
l.y_fold [
  (import ./ysets/core.nix l)
  (import ./ysets/bspwm.nix l)
  (import ./ysets/scripts.nix l)
  (import ./ysets/kakoune.nix l)
  (import ./ysets/lemonbar.nix l)
  (import ./ysets/misc.nix l)
  (s: {
    apps = {
      bspwm.enabled = true;
      fzf.enabled = true;

      kakoune.enabled = true;
      kakoune.plugins = with s.pkgs.kakounePlugins; { inherit kak-lsp; };

      lemonbar.enabled = true;
      lemonbar.config = with s.deps.crane-lib;
        buildPackage {
          src = ./config/lemonbar;
          cargoToml = ./config/lemonbar/Cargo.toml;
          doCheck = false;
          cargoArtifacts = buildDepsOnly {
            src = ./config/lemonbar;
            cargoToml = ./config/lemonbar/Cargo.toml;
          };
        };
    };

    env.pkgs = with s.pkgs;
      with xorg; {
        inherit xdotool xsel xset xrandr xsetroot neofetch zathura imagemagick
          sxiv lxappearance;
      };
    env.syms = {
	    "~/.config/X11" = ./config/X11;
	    "~/.config/Xresources" = ./config/Xresources;
	    "~/.config/alacritty" = ./config/alacritty;
	    "~/.config/neofetch" = ./config/neofetch;
	    "~/.config/newsboat" = ./config/newsboat;
	    "~/.config/picom" = ./config/picom;
	    "~/.bashrc" = ./config/bash/bashrc;
    };
  })
]
