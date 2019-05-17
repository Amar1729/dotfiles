#!/bin/bash

# Things to customize:
# _space_id:	change command to get current space
# new_terminal:	change command to spawn new terminal

ROOT="$HOME/.cache/wal"
declare -a FILES=(wp sequences colors.sh colors.css colors.json)

_space_id () {
    # (macOS)
	# prefer newer wm
    if /usr/local/bin/chunkc tiling::query --desktop id 2>/dev/null; then
        if /usr/local/bin/kwmc query space active id 2>/dev/null; then
            echo 1
        fi
    fi
}

_run_wal () {
	if [[ ! -f "$1" ]]; then exit 1; fi

	wal -sn -i "$1"

    cp "$1" ~/.cache/wal/wp
}

# generate a <space> filename
# e.g. wp -> wp_1, colors.sh -> colors_1.sh
fname_from_space () {
    SPACE=$1
    base=${2%.*} # colors.json -> colors
    ext=${2##*.} # colors.json -> json
    if [[ ${base} == ${ext} ]]; then # ext is [wp|sequences] (ie no extension)
        echo "${base}_${SPACE}"
    else
        echo "${base}_${SPACE}.${ext}"
    fi
}

_cache () {
    # files to cache found in global array FILES
    for f in ${FILES[@]}; do
        f_fname="${ROOT}/$f"
        t_fname="${ROOT}/$(fname_from_space $1 $f)"
        cp "$f_fname" "$t_fname"
    done
}

copy () {
    # files to copy found in global array FILES
    for f in ${FILES[@]}; do
        f_fname="${ROOT}/$(fname_from_space $1 $f)"
        t_fname="${ROOT}/$(fname_from_space $2 $f)"
        [[ -f "$f_fname" ]] && cp "$f_fname" "$t_fname"
    done
}

get_wallpaper () {
    SPACE=$(_space_id)
    FILE=~/.cache/wal/wp_$SPACE
    if [[ -e $FILE ]]; then
        echo $FILE
    else
        echo ""
    fi
}

# TODO - add a check for sequences files that apply to destroyed desktops?
change_wallpaper () {
	FILE="$(realpath "$1")"
	if [[ ! -f "$1" ]]; then exit 1; fi

    SPACE=$(_space_id)
	(_run_wal "$FILE" && _cache $SPACE $FILE) >/dev/null 2>&1 &
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

case "$1" in
    -c|--clean)
        rm -f ~/.cache/wal/wp_*
        rm -f ~/.cache/wal/sequences*
        rm -f ~/.cache/wal/colors_*
        ;;
    -w|--wallpaper)
        change_wallpaper "$2"
        ;;
    --get-wallpaper)
        # gets the current wallpaper (useful for other helper scripts)
        get_wallpaper
        ;;
    -r|--reload)
        reload_colors
        ;;
    --copy)
        [[ -z $2 || -z $3 ]] && echo 'Two arguments required.' && exit 1
        copy $2 $3
        ;;
    -n|--new)
        new_terminal
        ;;
esac

