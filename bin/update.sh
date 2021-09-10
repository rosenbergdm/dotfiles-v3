#! /usr/bin/env bash
# update.sh
# Copyright (C) 2021 David Rosenberg <dmr@davidrosenberg.me>
# Distributed under terms of the GPLv3 license.
#
# Usage: update.sh

export PATH=/usr/local/bin:$PATH
export TERM=dumb

brew=/usr/local/bin/brew
nvim=/usr/local/bin/nvim
Rscript=/usr/local/bin/Rscript
rustup=/Users/davidrosenberg/.cargo/bin/rustup

$brew update
$brew upgrade
$brew cleanup

$nvim --headless +CocUpdate +'call dein#install()' +qa
$Rscript <( ( echo 'devtools::update_packages(upgrade="always", build_opts = c("--with-keep.source", "--with-keep.parse.data", "--example", "--html", "--build-vignettes"), build_vignettes=TRUE)' ) )
$rustup update
