l: s:
with s; {
  doc."apps.lemonbar" = "Lemonbar as status bar";
  apps.lemonbar.enabled = false;
  doc."apps.lemonbar.config" = "The derivation of the lemonbar configuration";
  apps.lemonbar.config = null;

  outputs = l.set.optional apps.lemonbar.enabled {
    lemonbar-conf = apps.lemonbar.config;
  };
  env.pkgs = l.list.optionals apps.lemonbar.enabled [
    apps.lemonbar.config
    pkgs.lemonbar-xft
  ];
}
