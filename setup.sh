#!/bin/bash

URL='https://raw.githubusercontent.com/Amar1729/dotfiles/simple/'

declare -a files=(
.bash_profile
.amarrc
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

simple_files () {
    cd "$HOME" || return
    mkdir -p .vim/colors

    if [[ $# -gt 0 ]]; then
        while [[ $# -gt 0 ]]; do
            # save backups
            [[ -e $1 ]] && mv "$1" "$1"".bak"
            curl "${URL}${1}" -o "$1"
            shift
        done
    else
        for f in "${files[@]}"; do
            # save backups
            [[ -e $f ]] && mv "$f" "$f"".bak"
            curl "${URL}${f}" -o "$f"
        done
    fi
}


setup-zsh () {

    path_fix () {

        if ! command -v git 2>/dev/null; then
            echo "Install git first please"
            exit 1
        fi

        if ! command -v zsh 2>/dev/null; then
            echo "Install zsh first please"
            exit 1
        fi

        if ! grep '\.local\/bin' "$PATH" 2>/dev/null; then
            echo 'export $PATH="$PATH:$HOME/.local/bin' >> ~/.profile
        fi
        mkdir -p ~/.local/bin
    }

    # https://getantibody.github.io/install/
    # curl -sfL git.io/antibody | sh -s - -b /usr/local/bin
    set -e

    path_fix
    curl -sfL git.io/antibody | sh -s -- -b ~/.local/bin

    curl -sfL https://raw.githubusercontent.com/Amar1729/dotfiles/simple/.zshrc -o ~/.zshrc
    curl -sfL https://raw.githubusercontent.com/Amar1729/dotfiles/simple/.zsh_plugins.txt -o ~/.zsh_plugins.txt

    ~/.local/bin/antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh

    echo "Installed antibody and zsh plugins. You can run:"
    echo "$ chsh -s $(command -v zsh)"
    echo "Make sure to add the shell to /etc/shells if necessary."
}

# todo : bunch of pkg mgr installations (e.g. git, vim, etc)

key=$1
shift
case $key in
    zsh)
        setup-zsh
        ;;
    simple)
        simple_files "$@"
        ;;
esac
