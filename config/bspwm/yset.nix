l: s:
with s; {
  doc."apps.bspwm.enabled" = "Bspwm as window manager";
  apps.bspwm.enabled = false;
  doc."apps.bspwm.config" = "Bspwm config";
  apps.bspwm.config = { border_width = "0"; };

  env.pkgs = with pkgs;
    l.only_if apps.bspwm.enabled [ bspwm sxhkd xprompt hsetroot ];

  apps.bspwm.bspwmrc = ''
    #!${pkgs.oil}/bin/ysh

    mkdir -p ~/.cache/wm
    echo > ~/.cache/wm/log
    exec > ~/.cache/wm/log 2>&1
    echo "Initialized bspwm log"
    #########################################
    # create lock so only one instance can exist
    #########################################
    if test -e ~/.cache/wm/rc.lck {
      exit
    }
    touch ~/.cache/wm/rc.lck

    #####################
    # set up enviornment
    #####################
    echo $'\e[34m\e[1m::\e[37m Setting up environment variables...\e[0m'
    ${builtins.concatStringsSep "\n"
    (l.set.mapToValues (n: v: ''export ${n}=${v}'') user.envvars)}
    export SHELL=${shells.oil.path}

    # Means this is not run for the first time
    if ($1 > 1)  {
      echo $'\e[34m\e[1m::\e[37m killing duplicate processess..\e[0m'
      try {
        killall "picom" \
          "sxhkd" \
          "lemonbar" \
          "controllemonbar" \
          "dunst" \
          "xcape" \
          "pipewire" \
          "pipewire-pulse" \
          "wireplumber"
      }
    }

    # wallpaper
    echo $'\e[34m\e[1m::\e[37m Setting wallpaper...\e[0m'
    fork { hsetroot -solid '#2e3440' -fill ~/Pictures/wallpapers/fill.png -center ~/Pictures/wallpapers/center.png }

    echo -e $'\e[34m\e[1m::\e[37m Configuring X...\e[0m'
    xrandr -s 1366x768
    xsetroot -cursor_name left_ptr
    xset r rate 250 100

    # map keys
    xcape -e Super_L=Escape
    setxkbmap -option caps:super

    # load xresources
    echo $'\e[34m\e[1m::\e[37m Loading Xresources...\e[0m'
    xrdb ~/.config/Xresources/main # load Xresources
    #####################
    # daemons
    #####################
    echo $'\e[34m\e[1m::\e[37m Starting daemons...\e[0m'

    if ($1 >  1) {
      sxhkd &
    } else {
      sxhkd -m 1 &
    }
    picom &
    dunst &

    fork {
      controllemonbar | lemonbar -gx15 -f"Iosevka:pixelsize=13:antialias=true" -B#2e3440 -F#d8dee9 -U#88c0d0 -o2
    }

    pipewire &
    pipewire-pulse &
    wireplumber &

    # Startup
    ${builtins.concatStringsSep "\n" user.wm.startup}

    echo $'\e[34m\e[1m::\e[37m Configuring bspwm...\e[0m'
    bspc rule -a Notes state=floating sticky=on
    bspc rule -a firefox:*:Picture-in-Picture state=floating sticky=on
    bspc rule -a gimp state=tiling
    bspc rule -a Zathura state=tiling

    # Bspwm configuration
    ${builtins.concatStringsSep "\n"
    (l.set.mapToValues (n: v: "bspc config ${n} ${v}") apps.bspwm.config)}

    #####################
    # finish
    #####################
    echo $'\e[34m\e[1m::\e[37m Finished\e[0m'

    rm ~/.cache/wm/rc.lck # clean up lock
  '';

  env.syms = l.only_if apps.bspwm.enabled {
    "~/.config/bspwm" = builtins.derivation {
      name = "pheonix9001-bspwmrc";
      inherit system;

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
