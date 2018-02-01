#!/bin/bash

# amar paul's ubuntu config
# common apt-get installs and config for ubuntu/debian systems

# use this as reference for making home dir the dotfiles repo
import-dotfiles () {
	git init
	git remote add origin <remote_url>
	git fetch --all --prune

	# use this also once branch is dl'd to set HEAD properly (git reset is probably the important one)
	git branch --set-upstream-to=origin/master master
	git checkout master
	git stash
	git config user.name 
	git config user.email 
	git reset origin/master
	# is this the right one or does this fail?
	git checkout -t master
	git checkout -t origin/master
}

setup () {

	echo "creating Downloads/wm and ~/.config/ if it's not there"

	mkdir ~/Downloads/wm
	mkdir -p ~/.config/nvim

	git clone https://github.com/baskerville/bspwm ~/Downloads/wm/
	git clone https://github.com/baskerville/sxhkd ~/Downloads/wm/

	# setup nvim and zsh? 

	echo "Copied init.vim, make sure to install dein and edit paths"
	[[ -f ../../.config/nvim/init.vim ]] && cp ../../.config/nvim/init.vim ~/.config/nvim/init.vim

	echo "Copying zsh, oh-my-zsh, antigen ..."

	# https://github.com/robbyrussell/oh-my-zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# https://github.com/zsh-users/antigen
	curl -L git.io/antigen > ~/antigen.zsh
}


theming () {

	sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
	wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
	sudo apt-key add - < Release.key
	
	sudo apt-get update

	# Arc theme
	sudo apt-get install arc-theme unity-tweak-tool
}

editing () {
	# add repositories, then update
	# neovim stuff
	sudo add-apt-repository ppa:neovim-ppa/stable

	sudo apt-get update

	# Basic workflow, editing
	sudo apt-get install tmux
	sudo apt-get install python-pip software-properties-common python-dev python-pip python3-dev python3-pip

	sudo apt-get install neovim
	# If this fails (e.g. RPi) use nox instead:
	# sudo apt-get install vim-nox

	# dein
	mkdir -p ~/.config/nvim/
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.config/nvim/installer.sh

	# careful with the paths for this one o_O
	#sh ~/.config/nvim/installer.sh /home/apaul/.config/nvim
}

shell-changes () {
	# zsh
	# is the first curl necessary or for live?
	#curl -L git.io/antigen > antigen.zsh
	sudo apt-get install zsh
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
	git clone https://github.com/zsh-users/antigen.git

	# fonts
	#tar xvzf FantasqueSansMono.tar.gz
	#mkdir .fonts
	#mv Downloads/FantasqueSansMono.tar.gz .fonts
	#mkdir Fantasque
	#tar -xvzf FantasqueSansMono.tar.gz -C Fantasque
	#fc-cache -f -v

	# Do you still need this for pip?
	#sudo easy_install pip
	#sudo pip install virtualenv

	# Need to add jessie-backports
	# sudo apt-get -t jessie-backports install borgbackup

	# Common python/pip modules that should be systemwide
	sudo pip install virtualenv jedi
}

others () {
	# reversing
	sudo apt-get install wireshark lynx tshark radare radare2 
}

editing
