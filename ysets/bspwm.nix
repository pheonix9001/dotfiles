l: s:
with s; {
  # Bspwm as window manager
  apps.bspwm.enabled = false;
  env.pkgs = with s.pkgs;
    l.only_if apps.bspwm.enabled { inherit bspwm sxhkd xprompt hsetroot; };

  env.syms."~/.config/bspwm" = ../config/bspwm;
  env.syms."~/.config/sxhkd" = ../config/sxhkd;
}
