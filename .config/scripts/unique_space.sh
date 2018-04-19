#!/bin/bash

# Things to customize:
# _space_id:	change command to get current space
# new_terminal:	change command to spawn new terminal

_space_id () {
	# change command here?
	SPACE=$(/usr/local/bin/kwmc query space active id)
	#/usr/local/bin/chunkc tiling::query -d id
	echo $SPACE
}

_run_wal () {
	if [[ ! -f "$1" ]]; then exit 1; fi

	wal -sn -i "$1"
}

_cache_seq () {
	SPACE=$(_space_id)

	cp ~/.cache/wal/sequences ~/.cache/wal/sequences_"$SPACE"
}

# TODO - add a check for sequences files that apply to destroyed desktops?
change_wallpaper () {
	FILE="$(realpath "$1")"
	if [[ ! -f "$1" ]]; then exit 1; fi

	(_run_wal "$FILE" && _cache_seq) >/dev/null 2>&1 &
	osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$FILE\""
}

new_terminal () {
	osascript -e "tell application \"iTerm\" to create window with default profile"
}

reload_colors () {
	SPACE=$(_space_id)
	FILE=~/.cache/wal/sequences_"$SPACE"

	if [[ -f ~/.cache/wal/sequences_1 ]]
	then
		DEFAULT=~/.cache/wal/sequences_1
	else
		DEFAULT=~/.cache/wal/sequences
	fi

	if [[ -f $FILE ]]
	then
		(cat $FILE &)
	else
		(cat $DEFAULT &)
	fi
}

"$@"
