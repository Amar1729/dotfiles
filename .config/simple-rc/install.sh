#!/bin/bash

echo "Installing .bashrc, .shell_aliases, .vimrc, and .tmux.conf ..."

if [[ -e .bashrc ]]
then
	mv .bashrc .bash-default-rc
	echo "Backed up .bashrc to .bash-default-rc"
fi
echo ""

curl -O https://raw.githubusercontent.com/Amar1729/dotfiles/master/.config/simple-rc/.bashrc
curl -O https://raw.githubusercontent.com/Amar1729/dotfiles/master/.config/simple-rc/.vimrc
curl -O https://raw.githubusercontent.com/Amar1729/dotfiles/master/.config/simple-rc/.shell_aliases
curl -O https://raw.githubusercontent.com/Amar1729/dotfiles/master/.config/simple-rc/.tmux.conf
(mkdir -p .vim/colors && cd .vim/colors && \
curl -O https://raw.githubusercontent.com/Amar1729/dotfiles/master/.config/simple-rc/.vim/colors/zenburn.vim)

echo ""
echo "tmux: $(which tmux)"

