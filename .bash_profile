#!/opt/homebrew/bin/bash

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
    # 
    source "$HOME/.bashrc"
  fi
fi

# vim: ft=bash 
