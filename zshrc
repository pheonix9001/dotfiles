#!/bin/zsh

PROMPT="%F{1}%f %F{12}%~%F{8}>
 %F{2}λ%f "
HISTFILE=~/.cache/zsh/zshhistory

autoload -Uz compinit; compinit
source ~/programs/xplr/xplr.zsh
bindkey -v
bindkey '^?' backward-delete-char

# generic fuzzer
gf () {
	f="$(eval $1 | sk)"
	[[ -n $f ]] && $2 $f
}

alias nf="gf 'fd -t f' 'nvim'"
alias cf="gf 'fd -t d' 'cd'"
alias of="gf 'fd -t f' 'xdg-open'"

af () {
	output=$(sk -e --ansi -c "ag '{}' --color" -i)
	line="$(echo $output | cut -d: -f2)"
	file="$(echo $output | cut -d: -f1)"
	nvim -c "set nofoldenable" "+$line" "$file"
}

alias n="nvim"
alias tsm="transmission-remote"
alias zthr="zathura"
alias nj="ninja"

# git aliases
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gch="git checkout"
alias gd="git diff"
alias gr="git reset"
alias grm="git rm"
alias gs="git status"

alias cp="cp -i"
alias rm="rm -i"

DISABLE_AUTO_TITLE="true"
touch /dev/shm/pwd
chpwd () {
  print -Pn "\e]0;zsh:%~\a"
  killall "controllemonbar" -SIGUSR2
  pwd > /dev/shm/pwd
}
cd $(cat /dev/shm/pwd)

#nordic tty?
if [[ $TERM = "linux" ]]
then
	export PROMPT="%F{1}%f %F{10}%~%F{8}>
	%F{2}>%f "

	echo -en "\e]P02E3440"
	echo -en "\e]P1BF616A"
	echo -en "\e]P2A3BE8C"
	echo -en "\e]P3EBCB8B"
	echo -en "\e]P481A1C1"
	echo -en "\e]P5B48EAD"
	echo -en "\e]P688C0D0"
	echo -en "\e]P7D8DEE9"
	echo -en "\e]P84C566A"
	echo -en "\e]P9BF616A"
	echo -en "\e]PAA3BE8C"
	echo -en "\e]PBEBCB8B"
	echo -en "\e]PC81A1C1"
	echo -en "\e]PDB48EAD"
	echo -en "\e]PE8FBCBB"
	echo -en "\e]PFD8DEE9"

	clear
fi
