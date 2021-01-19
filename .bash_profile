# first thing's first, load in non-version-controlled stuff
if [ -f ~/.bash_private ]; then . "$HOME/.bash_private"; fi

# then the rest (exports, aliases, prompt, etc)
if [ -f ~/.bash_exports ]; then . "$HOME/.bash_exports"; fi
if [ -f ~/.bash_aliases ]; then . "$HOME/.bash_aliases"; fi
if [ -f ~/.bash_prompt ]; then . "$HOME/.bash_prompt"; fi
if [ -f ~/.bash_functions ]; then . "$HOME/.bash_functions"; fi
if [ -f ~/.rvm/scripts/rvm ]; then . "$HOME/.rvm/scripts/rvm"; fi
if [ -f ~/.travis/travis.sh ]; then . "$HOME/.travis/travis.sh"; fi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which phpenv > /dev/null; then eval "$(phpenv init -)"; fi
if which thefuck > /dev/null; then eval "$(thefuck --alias)"; fi
if which kubectl > /dev/null; then source <(kubectl completion bash); fi

if which brew &> /dev/null && [ -f "$(brew --prefix nvm)/nvm.sh" ]; then
  source $(brew --prefix nvm)/nvm.sh
fi

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

if [ $SUBSYSTEM == 'windows' ]; then
  env=~/.ssh/agent.env

  agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

  agent_start () {
      (umask 077; ssh-agent >| "$env")
      . "$env" >| /dev/null ; }

  agent_load_env

  # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
  agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

  if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
      agent_start
      ssh-add
  elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
      ssh-add
  fi

  unset env
fi

# autocorrect typos in path names when using `cd`
shopt -s cdspell;
