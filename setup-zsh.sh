#!/bin/bash

# https://getantibody.github.io/install/
# curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

path_fix () {
    if ! grep '\.local\/bin' "$PATH" 2>/dev/null; then
        echo 'export $PATH="$PATH:$HOME/.local/bin' >> ~/.profile
    fi
    mkdir -p ~/.local/bin
}

main () {
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

if ! command -v git 2>/dev/null; then
    echo "Install git first please"
    exit 1
fi

if ! command -v zsh 2>/dev/null; then
    echo "Install zsh first please"
    exit 1
fi

main
