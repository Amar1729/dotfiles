# Amar Paul's zshrc

export TERM="xterm-256color"
export EDITOR="nvim"

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# plugins: moving to antibody from antigen
ANTIBODY_HOME="$(antibody home)"
DISABLE_AUTO_UPDATE="true"

# for now use omz for better completions: todo remove this BLOAT
export ZSH="$ANTIBODY_HOME"/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh

# statically load plugins. generate with:
# antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh
source ~/.zsh_plugins.zsh

# User configuration

# PATH changes
[[ -r ~/.profile ]] && source ~/.profile

# shell aliases
[[ -r ~/.shell_aliases ]] && source ~/.shell_aliases

# a few zsh-specific aliases

alias dh='dirs -v'

# zsh options

DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome

# better globs
setopt extendedglob

# History

HISTCONTROL=ignoreboth
HISTFILESIZE=1000000
HISTSIZE=10000000           # number of history lines kept internally
SAVEHIST=10000000           # max number of history lines saved
setopt APPEND_HISTORY       # history appends to existing file
setopt HIST_REDUCE_BLANKS   # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_ALL_DUPS # ignore ALL duplicates (even if not immediately previous)
setopt histignoredups       # ignore duplicates during search

# ignore if beginning with space
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# save time and how long cmd ran
setopt EXTENDED_HISTORY

# newlines before and after command output
precmd () { print '' }
preexec () { print '' }

# CASE_SENSITIVE="true"
# case sensitive needs to be off; '_-' interchangeable.
HYPHEN_INSENSITIVE="true"

# some custom completions, and make sure $fpath gets loaded properly
compinit -i
