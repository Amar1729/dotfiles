# Amar Paul's zshrc

export TERM="xterm-256color"
export EDITOR="nvim"

# Path to your oh-my-zsh installation.
export ZSH=/Users/Amar/.oh-my-zsh

# my own theme!
ZSH_THEME="amar_simple"

# antigen (homebrew) path
source ~/antigen.zsh

# load oh-my-zsh's library
antigen use oh-my-zsh

# from default repo
antigen bundle git

# open GitHub from cli
antigen bundle peterhurford/git-it-on.zsh

# good ch dir backward (helpful for very nested projects)
antigen bundle Tarrasch/zsh-bd

# ranking of directories
export _Z_DATA="$HOME/.cache/z"
antigen bundle rupa/z

# include a notification for long-running commands or nonzero return codes
# make sure to install terminal-notifier (Mac) or notify-send (Linux)
#antigen bundle marzocchi/zsh-notify

# bundles (and env vars)
antigen bundle zsh-users/zsh-syntax-highlighting

#antigen bundle kennethreitz/autoenv
#AUTOENV_ENV_FILENAME="env"

# my theme:
#	style similar to powerlevel9k 
#	doesn't include virtualenvs in the first slice
#	DOES truncate dirpath to last 2 (or 25 chars)
#	- no battery status (i don't need this)
#	simpler vcs
#	TODO:
#		vcs: sha hash, working dir status, upstream status, commits ahead, etc ...
#	note - I liked pure theme. possible to create fork/temp for 'pure' work?

#antigen theme https://gist.github.com/Amar1729/fe38d56118d1211aff3638c95bc238a8 amar
antigen theme https://gist.github.com/Amar1729/80a6df13b218c6a47c01f48b5bef309c amar_simple

# done!
antigen apply


# User configuration

# PATH changes
[[ -r ~/.profile ]] && source ~/.profile

# shell aliases
[[ -r ~/.shell_aliases ]] && source ~/.shell_aliases

# History

HISTCONTROL=ignoreboth
HISTFILESIZE=1000000
HISTSIZE=10000000			# number of history lines kept internally
SAVEHIST=10000000			# max number of history lines saved
setopt APPEND_HISTORY		# history appends to existing file
setopt HIST_REDUCE_BLANKS	# trim multiple insgnificant blanks in history
setopt HIST_IGNORE_ALL_DUPS	# ignore ALL duplicates (even if not immediately previous)
setopt histignoredups		# ignore duplicates during search

# ignore if beginning with space
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# save time and how long cmd ran
setopt EXTENDED_HISTORY

# zsh: other look-and-feel, configs, aliases

# complex look-and-feel (airline theme to zsh prompt, vim, and tmux) by default
export COMPLEX=1

# don't write invalid commands into history (they are still cached locally)
# wip: _also_ ignore failed cmds?
zshaddhistory () { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# auto-source virtualenvs
chpwd () { [[ -r ./venv/bin/activate ]] && source ./venv/bin/activate }

# newlines before and after command output
precmd () { print '' }
preexec () { print '' }

# CASE_SENSITIVE="true"
# case sensitive needs to be off; '_-' interchangeable.
HYPHEN_INSENSITIVE="true"

fpath=(~/.zsh/completions $fpath)

zstyle ':completion:*' menu select
zmodload zsh/complist

# alt+, mirrors alt+. (insertion of command from last line vs insertion of last arg from last cmd)
insert-first-word () { zle insert-last-word -- -1 1 }
zle -N insert-first-word
bindkey '^[,' insert-first-word

# Use ctrl-p/n for up/down arrow (instead of default prev/next cmds)
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# temporarily clear cmd so i can inspect, ls, man, etc
bindkey '^q' push-line-or-edit

# Upon menu completion, enter directories with ctrl-o
bindkey -M menuselect '^o' accept-and-infer-next-history

# use the vi navigation keys in menu completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# autopushd		: make cd act like pushd (alias doesn't work properly)
# pushdminus	: use -1 instead of +1
# pushdsilent	: prevents printing stack on each cd
# pushdtohome	: `pushd` to ~/
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

# aliases for easier changing dir up
alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
