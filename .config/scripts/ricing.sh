#!/bin/bash

# A bunch of scripts to aid in window-manager, ricing, profiling etc setup
# Note - lots of these functions are probably Mac-specific

# wp: do a bunch of stuff! 
# most of this is MAC SPECIFIC
wp () {
	case $1 in
		-w|--wallpaper)
			~/.config/scripts/unique_space.sh change_wallpaper "$2"
			;;
		-n|--new)
			~/.config/scripts/unique_space.sh new_terminal
			;;
		-r|--reload)
			~/.config/scripts/unique_space.sh reload_colors
			;;
		-b|--both)
			wp -w "$2"
			sleep 1
			wp -r
			;;
		-f|--file)
			cat ~/.cache/wal/sequences_"$2"
			;;
		-t|--transparency)
			osascript -e "tell application \"iTerm\" to tell current window to tell current session to set transparency to $2"
			;;
		--tg|--transparency-get)
			osascript -e 'tell application "iTerm" to tell current window to tell current session to get transparency'
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
			print "\twp -w|--wallpaper FILE\t\tSet wallpaper to FILE, cache colors"
			print "\twp -n|--new \t\t\tNew iTerm window with default profile"
			print "\twp -r|--reload \t\t\tLoad space-specific colorscheme"
			print "\twp -b|--both FILE\t\tSet wallpaper and reload colors"
			print "\twp -f|--file NUMBER\t\tAttempt to load .cache/wal/sequences_NUMBER"
			print "\t\t\t\t\t\tNote - reloading too soon might not work for complex images"
			print "\twp -t|--transparency REAL\tSet transparency of terminal (0.0 to 1.0)"
			print "\twp --tg|--transparency-get\tGet the current terminal's transparency (0.0 to 1.0)"
			;;
		*)
			print "Not supported: ""$1"
			wp --help
			;;
	esac

	return 0
}

####
## theme/color quick testing
####

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
