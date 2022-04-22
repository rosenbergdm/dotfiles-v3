# Fig pre block. Keep at the top of this file.
. "$HOME/.fig/shell/bash_profile.pre.bash"
#!/opt/homebrew/bin/bash
# shellcheck disable=SC1090
# SC1090: Not all references will be resolvable

if [ -a "$HOME/DEBUG_STARTUP" ]; then
  if [[ "$(cat "$HOME/DEBUG_STARTUP")" == "" ]]; then
    file_dbg_startup=1
  else
    file_dbg_startup=$(cat "$HOME/DEBUG_STARTUP")
  fi
fi
export DEBUG_STARTUP=${DEBUG_STARTUP-${file_dbg_startup-0}}

if [ "$BASH_PROFILE_RUN" ]; then
  # i.e. we got called twice
  if [ "$DEBUG_STARTUP" ]; then
    printf "%s\n" "Warning: attempted to source .bash_profile more than once"
  fi
  # This will be a no-op
else
  [[ "$DEBUG_STARTUP:" == "1:" ]] && echo "Executing $HOME/.bash_profile from the top"
  export BASH_PROFILE_RUN=1
  if [ ! "$BASHRC_RUN" ]; then
    source "$HOME/.bashrc"
  fi
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# export PATH="$HOME/.poetry/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export BASH_PROFILE_RUN DEBUG_STARTUP BASHRC_RUN

# vim: ft=sh :

# Fig post block. Keep at the bottom of this file.
. "$HOME/.fig/shell/bash_profile.post.bash"
