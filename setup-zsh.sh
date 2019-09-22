#!/bin/bash

# https://getantibody.github.io/install/
# curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

path_fix () {
    if ! grep '\.local\/bin' "$PATH"; then
        echo 'export $PATH="$PATH:$HOME/.local/bin' >> ~/.profile
    fi
    mkdir -p ~/.local/bin
}

main () {
    path_fix
    curl -sfL git.io/antibody -o ~/.local/bin/antibody && chmod +x ~/.local/bin/antibody

    curl -sfL https://raw.githubusercontent.com/Amar1729/dotfiles/simple/.zshrc -o ~/.zshrc

    ~/.local/bin/antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh

    printf "Installed antibody and zsh plugins. You can run:"
    echo "$ chsh -s $(command -v zsh)"
    printf "Make sure to add the shell to /etc/shells if necessary."
}

if command -v zsh 2>/dev/null; then
    main
else
    printf "Install zsh first please"
fi
