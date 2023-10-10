l: s:
with s; {
  shells.oil.enabled = false;
  doc."shells.oil.enabled" = "Oil(Osh) as a shell";

  shells.oil.path = "${pkgs.oil}/bin/osh";
  shells.oil.rc = ''
    #!${pkgs.oil}/bin/osh

    shopt --set ysh:upgrade
    export PATH=$PATH:~/.local/bin

    export FZF_DEFAULT_OPTS="--height=70% --reverse --tiebreak=end,length,index --prompt=\"λ \""
    export RUSTFLAGS="-C target-feature=-crt-static"

    export PS1=$'\x1b[36m\\w\x1b[37;2m>\x1b[0m\n \x1b[32mλ \x1b[0m'

    # aliases
    alias watch='watch '
    alias doas='doas '
    alias entr='entr '

    # generic fuzzer
    proc gf(gen, cmd) {
    	const f = $(eval $run | fzf --ansi)
    	$cmd $f
    }

    alias ef="gf 'fd -t f --color always' '$EDITOR'"
    alias of="gf 'fd -t f --color always' 'xdg-open'"

    alias cf="gf 'fd -t d --color always' 'cd'"
    alias pf="gf 'fd -t d --color always' 'pushd'"
    alias pd="popd"

    proc af() {
    	const output = $(fzf --disabled -e --ansi --bind "change:reload:ag $@ --color {q} || true")
    	const line = $(echo $output | cut -d: -f2)
    	const file = $(echo $output | cut -d: -f1)
    	$EDITOR +$line $file
    }

    alias e="$EDITOR"
    alias tsm="transmission-remote"
    alias zthr="zathura"
    alias neofetch="neofetch --ascii ~/.config/neofetch/ascii/scp.ascii"
    alias update="doas pacman -Syu"

    alias dv="dirs -v"
    alias pd="pushd"
    alias ppd="popd"

    alias nj="ninja"
    alias njb="ninja -C build"
    alias mb="meson build"
    alias mc="meson configure build"

    # git aliases
    alias ga="git add"
    alias gb="git branch"
    alias gc="git commit"
    alias gch="git checkout"
    alias gd="git diff"
    alias gr="git reset"
    alias grm="git rm"
    alias gs="git status"
    alias gl="git log"

    alias cp="cp -i"
    alias rm="rm -i"

    touch /dev/shm/pwd
    function cd () {
    	builtin cd $@
    	# echo -en "\033]0;bash: $(pwd)\a"
    	pwd > /dev/shm/pwd
    }
    function lcd() {
    	builtin cd $@
    }
    cd $(cat /dev/shm/pwd)
  '';

  env = l.only_if shells.oil.enabled {
    pkgs = [ pkgs.oil ];
    syms = {
	  "~/.config/oils" = builtins.derivation {
        name = "oilrc";
        inherit system;
        oilrc = shells.oil.rc;
        builder = "${pkgs.oil}/bin/ysh";
        args = [
          "-c"
          ''
            ${pkgs.busybox}/bin/mkdir $out
            echo $oilrc > $out/oshrc
          ''
        ];
      };
    };
  };
}
