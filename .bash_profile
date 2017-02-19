# Amar Paul's .bash_profile
# Mac OS specific (i.e. specific to one computer)

# read .bashrc
[[ -r ~/.bashrc ]] && . ~/.bashrc

# and .profile
if [ -r ~/.profile ]; then . ~/.profile; fi

# rice scripts
[[ -r ~/.config/scripts/daytime.sh ]] && . ~/.config/scripts/daytime.sh
[[ -r ~/.config/airline-prompt.sh ]] && . ~/.config/airline-prompt.sh

# and temporary aliases
[[ -r ~/.bash_aliases_tmp ]] && . ~/.bash_aliases_tmp

# very rudimentary rename (or syntax for it)
#	for f in Game.of.Thrones.S03E*
#	 do
#	  new=${f/Game.of.Thrones./}
#	  new=${new/720p*/srt}
#	  mv $f $new
#	 done

# Open different Terminal windows
alias redsand="open ~/.terminal_profiles/Red\ Sands.terminal"
alias zenburn="open ~/.terminal_profiles/Zenburn.terminal"
alias soldark="open ~/.terminal_profiles/Solarized\ Dark\ ansi.terminal"
alias solit="open ~/.terminal_profiles/Solarized\ Light\ ansi.terminal"
alias novel="open ~/.terminal_profiles/Novel.terminal"

################
##
## Personal functions
##
################

# Switch iTerm2 profiles
# TODO: setup profile tab completion?
# http://tldp.org/LDP/abs/html/tabexpansion.html
itswitch () { echo -e "\033]50;SetProfile=$1\a" ; }

# Transfer iterm2 colorscheme from themer dir to itermcolors directory
itcolor () {
	file="$1"
	theme=$(basename $(dirname "$file"))
	cp "$file" "/Users/Amar/.config/iterm2_colors/""$theme"".itermcolors"
}

# Display terminal ANSI colors
termcolors() {
	# Print numbers
	echo -en "    \t"
	for i in {0..7}; do echo -en "  ${i}    \t"; done; echo

	# Print regular colors
	echo -en "reg:\t"
	for i in {0..7}; do echo -en "\033[0;3${i}m▉▉▉▉▉▉▉\t"; done; echo; echo
	
	# Print alternate colors
	echo -en "alt:\t"
	for i in {0..7}; do echo -en "\033[1;3${i}m▉▉▉▉▉▉▉\t"; done; echo
}

# Use neovim instead of vim
vimdiff () { nvim -d "$@" ;}

# use `highlight` for colorized cat
ccat () {
	if [ -f "$1" ]; then
		case "$1" in
			# force configuration file syntax for rc and profile files
			*rc)		highlight -O xterm256 --style=zenburn --syntax=conf -i "$1"	;;
			*profile)	highlight -O xterm256 --style=zenburn --syntax=conf -i "$1"	;;
			*)			highlight -O xterm256 --style=zenburn -i "$1"				;;
		esac
	else
		echo "$1"" is not a valid file"
	fi
}

# Use modified `ccat` function and `nl` to add line numbering
hcat () {
	NUMBER=0

	while [[ $# -gt 0 ]]
	do
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

####
##
##
##
####

################################################################
#### #### #### ####
#### #### #### ####
#
# Following modifications are from:
# http://natelandau.com/my-mac-osx-bash_profile/

#   ---------------------------------------
#   General
#   ---------------------------------------
# mcd:          Makes new Dir and jumps inside
#   I'm having second thoughts about whether this should use '-p' ?
mcd () { mkdir -p "$1" && cd "$1"; }

# Prevent power button from immediately sleeping display (fuck Dimoff)
alias PowerSleepOff='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no'
alias PowerSleepOn='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool yes'

# Move default screencap location
# Where I want them saved:
alias picDls='defaults write com.apple.screencapture location ~/Downloads/; killall SystemUIServer'
# Actual default:
alias picDef='defaults write com.apple.screencapture location ~/Desktop/; killall SystemUIServer'

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#### #### #### ####
#### #### #### #### End - Nate Landau's suggestions
################################################################
