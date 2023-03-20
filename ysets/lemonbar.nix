l: s:
with s; {
  # Lemonbar as status bar
  apps.lemonbar.enabled = false;
  # The derivation of the lemonbar configuration
  apps.lemonbar.config = null;

  outputs =
    l.set.optional apps.lemonbar.enabled { lemonbar-conf = apps.lemonbar.config; };
  env.pkgs = l.list.optionals apps.lemonbar.enabled [
    apps.lemonbar.config
    pkgs.lemonbar-xft
  ];
}
