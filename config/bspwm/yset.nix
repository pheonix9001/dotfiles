l: s:
with s; {
  # Bspwm as window manager
  apps.bspwm.enabled = false;
  # Bspwm config
  apps.bspwm.config = { border_width = "0"; };

  env.pkgs = with pkgs;
    l.only_if apps.bspwm.enabled [ bspwm sxhkd xprompt hsetroot ];
  user.wm.startup = [
    ''echo -e "\\e[34m\\e[1m::\\e[37m Configuring bspwm...\\e[0m"''
    "bspc rule -a Notes state=floating sticky=on"
    "bspc rule -a firefox:*:Picture-in-Picture state=floating sticky=on"
    "bspc rule -a gimp state=tiling"
    "bspc rule -a Zathura state=tiling"
  ] ++ l.set.mapToValues (n: v: "bspc config ${n} ${v}") apps.bspwm.config;

  apps.bspwm.bspwmrc = ''
    #!${pkgs.bash}/bin/bash

    mkdir -p ~/.cache/wm
    echo > ~/.cache/wm/log
    exec > ~/.cache/wm/log 2>&1
    echo -e "Initialized bspwm log"
    #########################################
    # create lock so only one instance can exist
    #########################################
    test -e ~/.cache/wm/rc.lck && exit
    touch ~/.cache/wm/rc.lck

    #####################
    # set up enviornment
    #####################
    echo -e "\\e[34m\\e[1m::\\e[37m Setting up environment variables...\\e[0m"

    export EDITOR=kak
    export BROWSER=firefox
    export TERMINAL=alacritty
    export SHELL=bash
    export USER_SHELL=${shells.${shells.default}.path}

    export PASSWORD_STORE_DIR=~/.local/password-store
    export LESSHISTFILE=~/.cache/lesshst
    export GNUPGHOME=~/.local/share/gnupg

    # if $1 is greater than 1 that means this is not run for the first time
    test $1 -gt 1 && (
    echo -e "\\e[34m\\e[1m::\\e[37m killing duplicate processess..\\e[0m"
    killall "picom" \
      "sxhkd" \
      "lemonbar" \
      "controllemonbar" \
      "dunst" \
      "xcape" \
      "pipewire" \
      "pipewire-pulse" \
      "wireplumber"
    )

    # wallpaper
    echo -e "\\e[34m\\e[1m::\\e[37m Setting wallpaper...\\e[0m"
    hsetroot -solid '#2e3440' -fill ~/Pictures/wallpapers/fill.png -center ~/Pictures/wallpapers/center.png &

    echo -e "\\e[34m\\e[1m::\\e[37m Configuring X...\\e[0m"
    xrandr -s 1366x768
    xsetroot -cursor_name left_ptr
    xset r rate 250 100

    # map keys
    xcape -e Super_L=Escape

    # load xresources
    echo -e "\\e[34m\\e[1m::\\e[37m Loading Xresources...\\e[0m"
    xrdb ~/.config/Xresources/main # load Xresources
    #####################
    # daemons
    #####################
    echo -e "\\e[34m\\e[1m::\\e[37m Starting daemons...\\e[0m"

    SHELL=bash test $1 -gt 1 && (sxhkd &) || sxhkd -m 1 &
    picom &
    dunst &

    ( controllemonbar | \
    lemonbar -gx15 -f"Iosevka:pixelsize=13:antialias=true" -B#2e3440 -F#d8dee9 -U#88c0d0 -o2 ) &

    pipewire &
    pipewire-pulse &
    wireplumber &

    mkdir -p $out

    # Startup
    ${builtins.concatStringsSep "\n" user.wm.startup}

    #####################
    # finish
    #####################
    echo -e "\\e[34m\\e[1m::\\e[37m Finished\\e[0m"

    rm ~/.cache/wm/rc.lck # clean up lock
  '';

  env.syms = l.only_if apps.bspwm.enabled {
    "~/.config/bspwm" = builtins.derivation {
      name = "pheonix9001-bspwmrc";
      system = s.system;

      src = ./.;
      binDeps = [ pkgs.busybox ];
      bspwmrc = apps.bspwm.bspwmrc;

      builder = "${pkgs.oil}/bin/oil";
      args = [
        "-c"
        ''
                  for dep in $binDeps {
          	     	  export PATH="$PATH:$dep/bin"
                  }
                  mkdir -p $out
                  echo $bspwmrc > $out/bspwmrc
                  chmod +x $out/bspwmrc
        ''
      ];
    };
    "~/.config/sxhkd" = ../sxhkd;
  };
}
