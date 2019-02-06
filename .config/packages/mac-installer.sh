#!/bin/bash

cd ~/

# setup dev environ
xcode-select install

# get Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install git binutils coreutils findutils

mkdir ~/.ssh
echo "make sure to run ssh-keygen"

# initialize git stuff
git init
git remote add origin git@github.com:Amar1729/dotfiles.git
git config user.name "Amar1729"
git config user.email "amar.paul16@gmail.com"
git fetch --all --prune
git checkout master

echo "Make sure to set global git uname/email"

brew install python python@2
brew install zsh antigen neovim
brew install tmux
