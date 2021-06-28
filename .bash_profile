# shellcheck shell=bash
# vi: ft=bash

# first thing's first, load in non-version-controlled stuff
if [ -f ~/.bash_private ]; then . "$HOME/.bash_private"; fi

# then the rest (exports, aliases, prompt, etc)
if [ -f ~/.bash_exports ]; then . "$HOME/.bash_exports"; fi
if [ -f ~/.bash_aliases ]; then . "$HOME/.bash_aliases"; fi
if [ -f ~/.bash_prompt ]; then . "$HOME/.bash_prompt"; fi
if [ -f ~/.bash_functions ]; then . "$HOME/.bash_functions"; fi
if [ -f ~/.rvm/scripts/rvm ]; then . "$HOME/.rvm/scripts/rvm"; fi

if command -v rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if command -v phpenv > /dev/null; then eval "$(phpenv init -)"; fi
if command -v thefuck > /dev/null; then eval "$(thefuck --alias)"; fi
if command -v kubectl > /dev/null; then source <(kubectl completion bash); fi

if command -v brew &> /dev/null && [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
  source "$(brew --prefix nvm)/nvm.sh"
fi

# Add tab completion for many Bash commands
if command -v brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
  # shellcheck disable=SC1091
	source /etc/bash_completion
fi

if command -v keychain &> /dev/null; then
  # load the ssh key
  keychain --nogui "$HOME/.ssh/id_rsa"
  source "$HOME/.keychain/$(hostname)-sh"
fi

# autocorrect typos in path names when using `cd`
shopt -s cdspell;
