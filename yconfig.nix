l:
l.y_fold [
  (import ./ysets/core.nix l)
  (import ./ysets/kakoune.nix l)
  (import ./ysets/lemonbar.nix l)
  (import ./ysets/misc.nix l)
  (import ./ysets/user.nix l)
  (import ./scripts/yset.nix l)
  (import ./config/bspwm/yset.nix l)
  (import ./config/nushell/yset.nix l)
  (s: {
    shells = {
      nushell.enabled = true;
      default = "nushell";
    };
    user.envvars = {
      EDITOR = "kak";
      BROWSER = "firefox";
      TERMINAL = "alacritty";
      SHELL = "bash";

      PASSWORD_STORE_DIR = "~/.local/password-store";
      LESSHISTFILE = "~/.cache/lesshst";
      GNUPGHOME = "~/.local/share/gnupg";
    };
    apps = {
      bspwm.enabled = true;
      bspwm.config = {
        border_width = "0";
        window_gap = "1";
        left_padding = "0";
        right_padding = "0";
        bottom_padding = "0";
        top_padding = "15";
        split_ratio = "0.30";
        automatic_scheme = "longest_side";
        directional_focus_tightness = "low";
        focus_follows_pointer = "true";
        pointer_follows_focus = "false";
        pointer_follows_monitor = "true";
        pointer_modifier = "mod4";
        pointer_action1 = "move";
        pointer_action2 = "resize_corner";
      };
      broot.enabled = true;

      kakoune.enabled = true;
      kakoune.plugins = with s.pkgs.kakounePlugins; [ kak-lsp kakboard ];

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
      with xorg; [
        xdotool
        xsel
        xset
        xrandr
        xsetroot
        neofetch
        zathura
        imagemagick
        sxiv
        lxappearance
      ];
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
