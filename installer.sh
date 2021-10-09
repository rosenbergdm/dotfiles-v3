#!/usr/bin/env bash

declare -a base_install_linux=( llvm autotools-dev libtool 
  build-essential python3-pip bash-completion postgresql 
  luarocks luajit curl wget cmake luajit-5.1-dev lua-mpack lua-lpeg 
  libunibilium-dev libmsgpack-dev libtermkey-dev 
  ninja-build gettext libtool libtool-bin autoconf automake 
  cmake g++ pkg-config unzip curl doxygen git gpg apache2 libapache2-mod-wsgi
  ccache)
declare -a npm_packages=()
declare -a ruby_packages=()
declare -a python_packages=()
declare -a go_packages=()
declare -a rust_packages=()
declare -a git_packages=()

# general packages
sudo apt update 
sudo apt install ${base_install_linux[@]}

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# go 
cd ~
mkdir -p src sys-setup
cd sys-setup
wget https://golang.org/dl/go1.17.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && tar -C /usr/local -xzf go*.tar.gz
cd ~

# python




# node
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node --latest-npm

# rvm 
gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
ruby_version="$(rvm list known | grep ruby-head  -B1 | head -n1 |perl -p -e 's/[\[|\]]//g')"
rvm install --docs --rdoc --yard $ruby_version
rvm 

