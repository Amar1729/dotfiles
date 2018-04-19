# Amar Paul's zshrc

export TERM="xterm-256color"
export EDITOR="nvim"

# Path to your oh-my-zsh installation.
export ZSH=/Users/Amar/.oh-my-zsh

# my own theme!
ZSH_THEME="amar_simple"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# antigen (homebrew) path
source /usr/local/share/antigen/antigen.zsh

# load oh-my-zsh's library
antigen use oh-my-zsh

# bundles from default repo
antigen bundle git
antigen bundle pip

#slows down shell startup :/
#antigen bundle command-not-found

# prettier display of JSON
antigen bundle jsontools

# open GitHub from cli
antigen bundle peterhurford/git-it-on.zsh

# include a notification for long-running commands or nonzero return codes
# make sure to install terminal-notifier (Mac) or notify-send (Linux)
antigen bundle marzocchi/zsh-notify

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

####
## History
####

HISTCONTROL=ignoreboth
HISTFILESIZE=1000000
HISTSIZE=10000000			# number of history lines kept internally
SAVEHIST=10000000			# max number of history lines saved
setopt APPEND_HISTORY		# history appends to existing file
setopt HIST_REDUCE_BLANKS	# trim multiple insgnificant blanks in history
setopt HIST_IGNORE_DUPS		# ignore duplicates and (?)

# ignore if beginning with space
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# save time and how long cmd ran
setopt EXTENDED_HISTORY

# export MANPATH="/usr/local/man:$MANPATH"

# newlines before and after command output
precmd() {print ''}
preexec() {print ''}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# complex look-and-feel (airline theme to zsh prompt, vim, and tmux) by default
export COMPLEX=1

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# necessary PATH changes
[[ -r ~/.profile ]] && source ~/.profile

# source shell aliases
[[ -r ~/.shell_aliases ]] && source ~/.shell_aliases

# ricing stuff
[[ -r ~/.config/scripts/ricing.sh ]] && source ~/.config/scripts/ricing.sh

# zsh-specific aliases

# autopushd		: make cd act like pushd (alias doesn't work properly)
# pushdminus	: use -1 instead of +1
# pushdsilent	: prevents printing stack on each cd
# pushdtohome	: `pushd` to ~/
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

# dynamic colors with (a wrapper for) pywal!
(~/.config/scripts/ricing.sh wp -r &)
