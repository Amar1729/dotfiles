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
			[[ -n "$2" ]] && PROF="$2" || PROF="gruvbox"
			osascript -e "tell application \"iTerm\" to create window with profile \"$PROF\""
			;;
		--bonsai)
			~/.config/scripts/bonsai.sh
			;;
		--coffee)
			~/.config/scripts/coffee.sh
			;;
		-h|--help)
			print "wp: Tool for on-the-fly screen changes."
			print "Usage:"
			print "\twp -w|--wallpaper FILE\t\tSet wallpaper to FILE"
			print "\twp -t|--transparency REAL\tSet transparency of terminal (0.0 to 1.0)"
			print "\twp --tg|--transparency-get\tGet the current terminal's transparency (0.0 to 1.0)"
			print "\twp -p|--profile PROFILE\t\tChange current profile to PROFILE"
			print "\twp -n|--new NAME\t\tNew terminal window with profile NAME"
			;;
		*)
			print "Not supported: ""$1"
			wp --help
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

####
## theme/color quick testing
####

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

####
## day/night changes
####

# changes to night mode
night() {
	open -a Flux
	# change colorshemes (?) and wallpapers

	export NIGHT=1
	return 0
}

# changes to day mode
day () {
	# Instead should progressively set Flux temp higher to ease transition
	killall Flux &> /dev/null
	# if Flux doesn't set to dark mode, don't need this toggle
	#khd -p "cmd + alt + ctrl - t"

	export NIGHT=0
	return 0
}

lock () {
	SCREEN_ENGINE="/System/Library/Frameworks/ScreenSaver.framework/Versions/Current/Resources/ScreenSaverEngine.app"
	open -a $SCREEN_ENGINE
}

toggle () {
	if [[ -z "$NIGHT" ]]; then
		export NIGHT=1
	fi

	if [[ "$NIGHT" ]]; then
		NIGHT=1
		day
	else
		NIGHT=0
		night
	fi
}

# If this script is called, call arguments verbatim (so I don't have to add to $PATH):
"$@"
