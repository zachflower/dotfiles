# shellcheck shell=bash
# vi: ft=bash

# check for various os openers
for opener in browser-exec xdg-open cmd.exe cygstart "start" open; do
	if command -v $opener >/dev/null 2>&1; then
		if [[ "$opener" == "cmd.exe" ]]; then
			# shellcheck disable=SC2139
			alias open="$opener /c start";
		else
			# shellcheck disable=SC2139
			alias open="$opener";
		fi

		break;
	fi
done

# detect which 'ls` flavor is in use
if ls --color > /dev/null 2>&1; then
   # gnu `ls`
   alias ls="ls --color"
else
   # osx `ls`
   alias ls="ls -G"
fi

alias v='vagrant'
alias screens='screen -ls'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if command -v bat > /dev/null; then
  alias cat='bat'
fi

if command -v htop > /dev/null; then
  alias top='htop'
fi

alias reload="source ~/.bash_profile"
