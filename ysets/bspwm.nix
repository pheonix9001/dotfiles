l:
l.y_add (s: {
  # Bspwm as window manager
  apps.bspwm.enabled = false;
}) (s:
  with s; {
    env.pkgs = with s.pkgs;
      l.only_if apps.bspwm.enabled { inherit bspwm sxhkd xprompt hsetroot; };

    env.syms."~/.config/bspwm" = ../config/bspwm;
  })
