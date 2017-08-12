#!/bin/bash

#curl -L git.io/antigen > antigen.zsh
#git clone https://github.com/zsh-users/antigen.git

# wm stuff
git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

tar xvzf FantasqueSansMono.tar.gz
mkdir ~/.fonts
mv Downloads/FantasqueSansMono.tar.gz ~/.fonts
mkdir Fantasque
tar -xvzf FantasqueSansMono.tar.gz -C Fantasque
fc-cache -f -v

