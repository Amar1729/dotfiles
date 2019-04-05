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

if [[ $# -gt 0 ]]; then
    while [[ $# -gt 0 ]]; do
        # save backups
        [[ -e $1 ]] && mv $1 "$1"".bak"
        curl "${URL}${1}" -o $1
        shift
    done
else
    for f in ${files[@]}; do
        # save backups
        [[ -e $f ]] && mv $f "$f"".bak"
        curl "${URL}${f}" -o $f
    done
fi

# todo : bunch of pkg mgr installations (e.g. git, vim, etc)
