l: s:
with s; {
  doc."apps.kakoune" = "Kakoune for text editing";
  doc."apps.kakoune.enabled" = "Enable kakoune";
  apps.kakoune.enabled = false;

  doc."apps.kakoune.plugins" = "Plugins used by kakoune";
  apps.kakoune.plugins = [ ];

  env.pkgs = l.list.optionals apps.kakoune.enabled [
    (pkgs.kakoune.override { plugins = apps.kakoune.plugins; })
    pkgs.rust-analyzer
    pkgs.rustfmt
  ];

  env.syms."~/.config/kak" = ./.;
}
