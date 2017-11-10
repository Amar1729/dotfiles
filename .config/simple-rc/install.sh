#!/bin/bash

echo "Installing .bashrc, .shell_aliases, .vimrc, and .tmux.conf ..."

if [[ -e .bashrc ]]
then
	mv .bashrc .bash-default-rc
	echo "Backed up .bashrc to .bash-default-rc"
fi
echo ""

curl -O https://gist.githubusercontent.com/Amar1729/f6746935cfd56cbe23e147a7950cf837/raw/.bashrc
curl -O https://gist.githubusercontent.com/Amar1729/f6746935cfd56cbe23e147a7950cf837/raw/.shell_aliases
curl -O https://gist.githubusercontent.com/Amar1729/f6746935cfd56cbe23e147a7950cf837/raw/.vimrc
curl -O https://gist.githubusercontent.com/Amar1729/f6746935cfd56cbe23e147a7950cf837/raw/.tmux.conf

echo ""
echo "tmux: $(which tmux)"

