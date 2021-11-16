#! /usr/bin/env bash

set -ex

if [[ ! -d "$HOME"/.mobymac ]]; then
    git clone https://github.com/dziemba/mobymac ~/.mobymac

    cd ~/.mobymac && ./install.sh
fi
