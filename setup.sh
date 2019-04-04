#!/bin/bash

URL='https://raw.githubusercontent.com/Amar1729/dotfiles/simple/'

declare -a files=(
.bash_profile
.bashrc
.gitconfig
.gitignore_global
.inputrc
.screenrc
.shell_aliases
.tmux-server.conf
.tmux.conf
.vim/colors/zenburn.vim
.vimrc
)

cd $HOME
mkdir -p .vim/colors
for f in ${files[@]}; do
    # save backups
    [[ -e $f ]] && mv $f "$f"".bak"
    curl "${URL}${f}" -o $f
done

# todo : bunch of pkg mgr installations (e.g. git, vim, etc)
