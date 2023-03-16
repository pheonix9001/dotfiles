l: s:
with s; {
  # Broot for fuzzy searching
  apps.broot.enabled = false;
  # Fzf for fuzzy searching
  apps.fzf.enabled = false;

  env.pkgs = with pkgs;
    l.only_if apps.broot.enabled { inherit broot; }
    // l.only_if apps.fzf.enabled { inherit fd fzf; };
  env.syms."~/.config/broot" = ../config/broot;
}
