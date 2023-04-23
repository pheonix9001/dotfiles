l: s:
with s; {
  doc."apps.broot.enabled" = "Broot for fuzzy searching";
  apps.broot.enabled = false;
  doc."apps.fzf.enabled" = "Fzf for fuzzy searching";
  apps.fzf.enabled = false;

  env.pkgs = with pkgs;
    l.list.optionals apps.broot.enabled [ broot ]
    ++ l.list.optionals apps.fzf.enabled [ fd fzf ];
  env.syms."~/.config/broot" = ../config/broot;
}
