#!/opt/homebrew/bin/bash

# Fig pre block. Keep at the top of this file.
# # shellcheck disable=SC1090
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
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"/Users/dmr/.local/share/lunarvim"}"
export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"/Users/dmr/.config/lvim"}"
export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"/Users/dmr/.cache/lvim"}"
export VIMINIT="$LUNARVIM_RUNTIME_DIR/lvim/init.lua"
export DENO_INSTALL="/Users/dmr/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# export PATH="$HOME/.poetry/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export NEOVIM_BIN=/usr/local/bin/nvim
export BASH_PROFILE_RUN DEBUG_STARTUP BASHRC_RUN

# vim: ft=sh :

# Fig post block. Keep at the bottom of this file.
#

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<



# Added by Toolbox App
export PATH="$PATH:/Users/dmr/Library/Application Support/JetBrains/Toolbox/scripts"
