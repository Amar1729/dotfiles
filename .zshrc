# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$PATH:/opt/bin

# source my bashrc and ricing scripts (switching shells takes a while)
[[ -r ~/.bashrc ]] && source ~/.bashrc
[[ -r ~/.config/scripts/ricing.sh ]] && source ~/.config/scripts/ricing.sh

export TERM="xterm-256color"

# Path to your oh-my-zsh installation.
export ZSH=/Users/Amar/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amar"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Don't need this if calling `antigen use oh-my-zsh`
#source $ZSH/oh-my-zsh.sh

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
# private gist while I work on my own theme:
antigen theme https://gist.github.com/Amar1729/fe38d56118d1211aff3638c95bc238a8 amar

# done!
antigen apply


# User configuration

###
# History
###

setopt APPEND_HISTORY          # history appends to existing file
setopt HIST_REDUCE_BLANKS      # trim multiple insgnificant blanks in history
HISTCONTROL=ignoreboth
HISTFILESIZE=1000000
HISTSIZE=10000000               # number of history lines kept internally
SAVEHIST=10000000               # max number of history lines saved
setopt APPEND_HISTORY          # history appends to existing file
setopt HIST_REDUCE_BLANKS      # trim multiple insgnificant blanks in history
setopt HIST_IGNORE_DUPS			# ignore duplicates and (?)

# ignore if beginning with space
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE

# save time and how long cmd ran
setopt EXTENDED_HISTORY

###

# export MANPATH="/usr/local/man:$MANPATH"

# newlines before and after command output
precmd() {print ''}
preexec() {print ''}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR="nvim"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# tab completion for my defined profiles
compctl -k "(gruvbox adwaita blaziken animeswing koe display changer blaziken2)" prof

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d $HOME/.rvm/bin ]] && export PATH="$PATH:$HOME/.rvm/bin"
