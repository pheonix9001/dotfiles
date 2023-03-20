l: s:
with s; {
  # Broot for fuzzy searching
  apps.broot.enabled = false;
  # Fzf for fuzzy searching
  apps.fzf.enabled = false;

  env.pkgs = with pkgs;
    l.list.optionals apps.broot.enabled [ broot ]
    ++ l.list.optionals apps.fzf.enabled [ fd fzf ];
  env.syms."~/.config/broot" = ../config/broot;
}
