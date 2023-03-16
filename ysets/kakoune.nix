l: s:
with s; {
  # Kakoune for text editing
  apps.kakoune.enabled = false;
  # Plugins used by kakoune
  apps.kakoune.plugins = { };

  env.pkgs = l.only_if apps.kakoune.enabled {
    kakoune = pkgs.kakoune.override {
      plugins = builtins.attrValues apps.kakoune.plugins;
    };
    rust-analyzer = pkgs.rust-analyzer;
    rustfmt = pkgs.rustfmt;
  };

  env.syms."~/.config/kak" = ../config/kak;
}
