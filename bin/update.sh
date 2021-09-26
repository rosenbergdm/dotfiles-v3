#! /usr/bin/env bash
# update.sh
# Copyright (C) 2021 David Rosenberg <dmr@davidrosenberg.me>
# Distributed under terms of the GPLv3 license.
#
# Usage: update.sh

export PATH=/usr/local/bin:$PATH
export TERM=dumb

brew=/usr/local/bin/brew
# nvim=/usr/local/bin/nvim
lvim=$HOME/.local/bin/lvim
Rscript=/usr/local/bin/Rscript
rustup=$HOME/.cargo/bin/rustup

$brew update
$brew upgrade
$brew cleanup

# $nvim --headless +CocUpdate +'call dein#install()' +qa
(cd "$HOME/.local/share/lunarvim/lvim; git pull")
$Rscript <( ( echo 'devtools::update_packages(upgrade="always", build_opts = c("--with-keep.source", "--with-keep.parse.data", "--example", "--html", "--build-vignettes"), build_vignettes=TRUE)' ) )
$rustup update
$lvim --headless +TSUpdate +PackerSync +PackerCompile \
  +"PackerLoad nvim-lspinstall" +"LspInstall lua" +"LspInstall bash" +'NlspUpdateSettings sumneko_lua' +'NlspUpdateSettings bashls' \
  +messages +quit


