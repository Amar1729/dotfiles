# Amar Paul's .bashrc

# read .profile
[[ -r ~/.profile ]] && source ~/.profile

# and temporary aliases
[[ -r ~/.bash_aliases_tmp ]] && source ~/.bash_aliases_tmp

# rice scripts
[[ -r ~/.config/scripts/ricing.sh ]] && source ~/.config/scripts/ricing.sh
#[[ -r ~/.config/airline-prompt.sh ]] && . ~/.config/airline-prompt.sh

# rudimentary rename (or syntax for it)
# for f in Game.of.Thrones.S03E*
#  do
#   new=${f/Game.of.Thrones./}
#   new=${new/720p*/srt}
#   mv $f $new
#  done

# Python shell tab completion
export PYTHONSTARTUP="$(python -m jedi repl)"

################
##
## Personal aliases, functions
##
################

# Open different Terminal profiles
alias redsand="open ~/.terminal_profiles/Red\ Sands.terminal"
alias zenburn="open ~/.terminal_profiles/Zenburn.terminal"
alias soldark="open ~/.terminal_profiles/Solarized\ Dark\ ansi.terminal"
alias solit="open ~/.terminal_profiles/Solarized\ Light\ ansi.terminal"
alias novel="open ~/.terminal_profiles/Novel.terminal"

alias pi="ssh pi@192.168.1.120"
alias pi-ext="ssh pi@bass2000.ddns.net"

###
# Common aliases, command improvements:
###

# Set default editor
export EDITOR="nvim"

# ls, grep, mkdir, tmux improvements
alias ll="ls -lhFG"
alias la="ll -a"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"
alias ggrep="ggrep --color=auto"
alias cclear="cd; clear"

# Make new directory and immediately cd into it (from Nate Landau's, link below)
# should the -p flag be included?
mcd () { mkdir -p "$1" && cd "$1"; }

# Use neovim instead of vim
alias vi="nvim"
alias vim="nvim"
vimdiff () { nvim -d "$@" ;}

# TODO:
# [c|h]cat needs improvement
# use `highlight` for colorized cat
ccat () {
  if [ -f "$1" ]; then
    case "$1" in
		# force configuration file syntax for rc and profile files
		*rc|*profile)
			highlight -O xterm256 --style=zenburn --syntax=conf -i "$1"
			;;
		*)
			highlight -O xterm256 --style=zenburn -i "$1"
			;;
    esac
  else
    echo "$1"" is not a valid file"
  fi
}

# Use modified `ccat` function and `nl` to add line numbering
hcat () {
  NUMBER=0

  while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -n)
      NUMBER=1
      ;;
    *)
      if [ $NUMBER -eq 0 ]
      then
        ccat "$key"
      else
        ccat "$key" | nl
      fi
      ;;
  esac
  shift
  done

  unset NUMBER
}

# make tmux easier to check
alias tmux-ls="/usr/local/bin/tmux list-sessions"
# tmux-a [index]	: attaches to the index of given session
# tmux-a			: tries to attach to last session; if none active, creates new one
tmux-a () {
	sessions=`tmux list-sessions 2>/dev/null`
	# if there are tmux sessions, connect to the last one or the one specified by $1
	if [[ $? -eq 0 ]]
	then
		# if there's an argument given then connect to given session
		if [[ -n "$1" ]]
		then
			tmux attach -t "$1"
			#return $?
		else
			# no argument, and tmux is running: attach to the most recent session
			tmux attach
			#return $?
		fi
	else
		# tmux isn't running: start it up
		tmux
		#return 0
	fi
}

###
# Some function calls to ricing.sh (in case I call from cmd line)
###

day () { ~/.config/scripts/ricing.sh day ;}
night () { ~/.config/scripts/ricing.sh night ;}

###
# General computer mgmt aliases and functions
###

# Open the screensaver with `lock`. Set preferences to lock the screen after 5s of screensaver
alias lock="open -a ScreenSaverEngine"

# reboot wifi (my router will occasionally boot my computer off)
alias wifi-toggle="networksetup -setairportpower en0 off; \
					networksetup -setairportpower en0 on"


###
# http://tex.stackexchange.com/questions/43057/macosx-pdf-viewer-automatic-reload-on-file-modification
# setup Skim for vim latex pdf previewing
# defaults write -app Skim SKAutoReloadFileUpdate -boolean true

###
# Following suggestions are from:
# http://natelandau.com/my-mac-osx-bash_profile/

# Prevent power button from immediately sleeping display
alias PowerSleepOff='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no'
alias PowerSleepOn='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool yes'

# Move default screencap location (only have to run this once, but saved here just in case)
# Where I want them saved:
alias picDls='defaults write com.apple.screencapture location ~/Downloads/; killall SystemUIServer'
# Actual default:
alias picDef='defaults write com.apple.screencapture location ~/Desktop/; killall SystemUIServer'

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias delDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finder-unhide:      Show hidden files in Finder
#   finder-hide:	    Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finder-unhide='defaults write com.apple.finder ShowAllFiles TRUE'
alias finder-hide='defaults write com.apple.finder ShowAllFiles FALSE'

###
# End of Nate Landau's suggestions
###
