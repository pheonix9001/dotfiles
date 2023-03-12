l:
l.y_fold [
  (l.mkY {
    # Broot for fuzzy searching
    apps.broot.enabled = false;
    # Fzf for fuzzy searching
    apps.fzf.enabled = false;
  })
  (s: with s; {
    env.pkgs = l.only_if apps.broot.enabled { broot = pkgs.broot; };
    env.syms."~/.config/broot" = ../config/broot;
  })
  (s: with s; {
    env.pkgs = l.only_if apps.fzf.enabled (with pkgs; { inherit fd fzf; });
  })
]
