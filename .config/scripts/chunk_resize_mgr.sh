#!/bin/bash

# this is a DIRTY WORKAROUND SCRIPT
# chunkwm doesn't allow resizing of floating windows
# this script is for resizing regular OR floating windows with the same keybind

: << end
# original chunkwm/khd cmds

# increase region size
lalt - h : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge west
lalt - j : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge south
lalt - k : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge north
lalt - l : chunkc tiling::window --use-temporary-ratio 0.1 --adjust-window-edge east

# decrease region size
shift + lalt - h : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge west
shift + lalt - j : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge south
shift + lalt - k : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge north
shift + lalt - l : chunkc tiling::window --use-temporary-ratio -0.1 --adjust-window-edge east
end

resize_nonfloat () {
    # usage:
    # resize_nonfloat --increase|--decrease [west|south|north|east]
    # defaults to 0.1 change

    case "$1" in
        --increase)     RATIO="0.1"     ;;
        --decrease)     RATIO="-0.1"    ;;
    esac

    chunkc tiling::window --use-temporary-ratio "$RATIO" --adjust-window-edge "$2"
}

resize_float () {
    # usage:
    # resize_nonfloat --increase|--decrease [west|south|north|east] [int]
    # defaults to 2 change

    case "$2" in
        west)
            DIR="w"
            ;;
        east)
            DIR="e"
            ;;
        south)
            DIR="s"
            ;;
        north)
            DIR="n"
            ;;
    esac

    ~/.config/scripts/chunk_float.sh dilate "$1" $DIR "$3"
}

if [[ $(chunkc tiling::query -w float) -eq 0 ]]; then
    resize_nonfloat "$@"
else
    resize_float "$@"
fi
