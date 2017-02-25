# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

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

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# Don't need this if calling `antigen use oh-my-zsh`
#source $ZSH/oh-my-zsh.sh

# Powerlevel9K customization (similar to included agnoster prompt)
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_CUSTOM_USER="print -P $USER"
POWERLEVEL9K_CUSTOM_USER_BACKGROUND="black"
POWERLEVEL9K_CUSTOM_USER_FOREGROUND="alt_white"
POWERLEVEL9K_BATTERY_VERBOSE="false"
POWERLEVEL9K_BATTERY_ICON=""
POWERLEVEL9K_STATUS_VERBOSE="false"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv custom_user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status battery)

# gruvbox-powerline customization
ZSH_POWERLINE_SINGLE_LINE="true"
ZSH_POWERLINE_SHOW_IP="false"
ZSH_POWERLINE_SHOW_TIME="false"
POWERLINE_RIGHT_A=" "
POWERLINE_RIGHT_B="none"

# antigen (homebrew) path
source /usr/local/share/antigen/antigen.zsh

# load oh-my-zsh's library
antigen use oh-my-zsh

# bundles from default repo
antigen bundle git
antigen bundle pip
#antigen bundle command-not-found

# bundles (and env vars)
antigen bundle zsh-users/zsh-syntax-highlighting

#antigen bundle kennethreitz/autoenv
#AUTOENV_ENV_FILENAME="env"

# theme
#antigen theme agnoster
#source ~/.oh-my-zsh/custom/amar.zsh-theme
#antigen theme bhilburn/powerlevel9k powerlevel9k
#antigen theme commanderkelso/oh-my-zsh-gruvbox-powerline-theme gruvbox-powerline
#antigen bundle mafredri/zsh-async
#antigen bundle sindresorhus/pure

# my theme:
#	doesn't include virtualenvs in slices
#	includes failed command at beginning of name (change?)
#	doesn't include any git info
#	DOES truncate dirpath to last 2
#	colors similar to powerlevel9k 
#	- battery status ? (eh)
#	vcs:
#		sha hash, working dir status, upstream status, commits ahead, etc ...
#	liked pure theme. possible to create fork/temp 'pure' work?
# private gist while I work on my own theme
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
HISTFILESIZE=100000
HISTSIZE=1000000               # number of history lines kept internally
SAVEHIST=1000000               # max number of history lines saved

###

# export MANPATH="/usr/local/man:$MANPATH"

# newlines before and after command output
precmd() {print ''}
preexec() {print ''}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# tab completion for my defined profiles
compctl -k "(gruvbox adwaita blaziken animeswing koe display changer)" prof



