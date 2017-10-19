#!/bin/bash

# A bunch of scripts to aid in window-manager, ricing, profiling etc setup
# Note - lots of these functions are probably Mac-specific

# wp: do a bunch of stuff! 
# most of this is MAC SPECIFIC
wp () {
	key=$1
	case $key in
		-w|--wallpaper)
			wp-wallpaper "$2"
			;;
		-t|--transparency)
			osascript -e "tell application \"iTerm\" to tell current window to tell current session to set transparency to $2"
			;;
		--tg|--transparency-get)
			osascript -e 'tell application "iTerm" to tell current window to tell current session to get transparency'
			;;
		-p|--profile)
			echo -e "\033]50;SetProfile=$2\a"
			;;
		-n|--new)
			# (not done: this needs to open new window)
			osascript -e "tell application \"iTerm\" to create window with profile \"$2\""
			;;
		--bonsai)
			~/.config/scripts/bonsai.sh
			;;
		--coffee)
			~/.config/scripts/coffee.sh
			;;
		*)
			echo "Not supported: ""$1"
			echo "wp: Tool for on-the-fly screen changes."
			print "Usage:"
			print "\twp -w|--wallpaper FILE\t\tSet wallpaper to FILE"
			print "\twp -t|--transparency REAL\tSet transparency of terminal (0.0 to 1.0)"
			print "\twp --tg|--transparency-get\tGet the current terminal's transparency (0.0 to 1.0)"
			print "\twp -p|--profile PROFILE\t\tChange current profile to PROFILE"
			print "\twp -n|--new NAME\t\tNew terminal window with profile NAME"
			;;
	esac

	return 0
}

wp-wallpaper () {
	file="$(realpath "$1")"
	if [[ -f "$file" ]]
	then
		osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$file\""
	else
		echo "Not a valid file"
	fi
}

###
# theme/color quick testing
###

# Switch iTerm2 profiles
# tab completion done for zsh (see .zshrc)
# bash?:
# http://tldp.org/LDP/abs/html/tabexpansion.html
# ITERM2 ONLY
prof () { echo -e "\033]50;SetProfile=$1\a" ; }

# Transfer iterm2 colorscheme from themer dir to itermcolors directory
# PERSONAL USE
iterm-transfer () {
  file="$1"
  theme=$(basename $(dirname "$file"))
  cp "$file" "/Users/Amar/.config/iterm2/""$theme"".itermcolors"
}

# resets current song display (e.g. if firefox is closed)
alias reset-song="echo 'hack the planet' > ~/.config/song.txt"

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

###
# Functions for managing Flux (easier transitions, commandline ctrl, etc)
###

# From http://apple.stackexchange.com/questions/12719/how-can-i-adjust-the-apparent-color-temperature-of-my-display-in-os-x/51589#51589
# Change Flux temp
flux-temp () {
	if [[ ! -z "$1" && "$1" -ge 2700 && "$1" -le 6500 ]]; then
	  defaults write org.herf.Flux dayColorTemp -int "$1"
	  defaults write org.herf.Flux nightColorTemp -int "$1"
	  killall Flux
	  open /Applications/Flux.app
	else
	  echo "provide a temperature between 2700 and 6500 (rounded to nearest 100)"
	fi

	return 0
}

# When shutting down Flux, want to gradually increase temp so transition isn't as abrupt
flux-gradual-kill () {
	# flux-higher
	return 0
}

# changes to night mode
night() {
	open -a Flux
	# should I also change any color schemes here?
	return 0
}

# changes to day mode
day () {
	# Instead should progressively set Flux temp higher to ease transition
	killall Flux
	# if Flux doesn't set to dark mode, don't need this toggle
	#khd -p "cmd + alt + ctrl - t"
	return 0
}

# increase Flux temperature (more blue)
flux-higher() {
	# get current Flux temp
	# Increase it by 100 if lower than 6500 (?)
	return 0
}

# decrease Flux temperature (more orange)
flux-lower () {
	# get current Flux temp
	# Decrease by 100 ( if higher than 2700 (?) )
	return 0
}

# If this script is called, call arguments verbatim (so I don't have to add to $PATH):
"$@"
