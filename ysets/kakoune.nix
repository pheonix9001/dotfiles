l: s:
with s; {
  # Kakoune for text editing
  apps.kakoune.enabled = false;
  # Plugins used by kakoune
  apps.kakoune.plugins = [ ];

  env.pkgs = l.list.optionals apps.kakoune.enabled [
    (pkgs.kakoune.override { plugins = apps.kakoune.plugins; })
    pkgs.rust-analyzer
    pkgs.rustfmt
  ];

  env.syms."~/.config/kak" = ../config/kak;
}
