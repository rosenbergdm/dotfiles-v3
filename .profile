#!/usr/bin/env bash
# Fig pre block. Keep at the top of this file.
# # [[ "$DEBUG_STARTUP:" == "1:" ]] && echo "RUNNING $HOME/.profile"
export HOME=~
export SHELL=$0
echo "RUNNING $HOME/.profile"
export PROFILE_RUN=1
# if [  -z "$BASHRC_RUN" ]; then
#   # .bashrc has not been run
#   . $HOME/.bashrc
# fi

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH
# alias gmvault=/usr/local/bin/gmvault

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=-1
export HISTFILESIZE=-1
shopt -s histappend

# [ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# rvm use 3.0

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" # This loads nvm
nvm use 16.10
source "$HOME/.cargo/env"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="$HOME/.poetry/bin:$PATH"
echo $PATH
# Fig post block. Keep at the bottom of this file.
#
