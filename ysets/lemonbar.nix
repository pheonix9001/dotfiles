l: s:
with s; {
  # Lemonbar as status bar
  apps.lemonbar.enabled = false;
  # The derivation of the lemonbar configuration
  apps.lemonbar.config = null;

  env.pkgs = l.only_if apps.lemonbar.enabled {
    lemonbar-conf = apps.lemonbar.config;
    lemonbar = pkgs.lemonbar-xft.overrideAttrs
      (old: { buildInputs = old.buildInputs ++ [ apps.lemonbar.config ]; });
  };
}
