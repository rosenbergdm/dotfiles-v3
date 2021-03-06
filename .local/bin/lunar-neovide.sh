#!/bin/sh

export XDG_DATA_HOME="/Users/dmr/.local/share/lvim"
export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"/Users/dmr/.local/share/lunarvim"}"
export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"/Users/dmr/.config/lvim"}"
export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"/Users/dmr/.cache/lvim"}"
exec $HOME/src/neovide/target/release/neovide -- -u $LUNARVIM_RUNTIME_DIR/lvim/init.lua $@
