# Amar Paul's .bashrc
# General stuff (put this on all of my *nix machines)

# When shell exits, append history
shopt -s histappend

# Explicitly ignore commands starting with space and duplicates
export HISTCONTROL=ignoreboth
export HISTFILESIZE=100000

# Terminal Profile
# Helpful: http://blog.taylormcgann.com/tag/prompt-color/
# Old:
#   export PS1="\h:\W \u\$ "
export PS1="\[\033[1;37m\]\u\[\033[1m\]: \[\033[1;31m\]\W\[\033[0m\] $ "   # white name, red directory
# export PS1="\[\033[1;37m\]\u\[\033[1m\] : \[\033[1;32m\]\W\[\033[0m\] $ "

# My aliases:
alias ll="ls -lhFG"
alias la="ll -a"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

