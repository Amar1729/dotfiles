#!/usr/local/bin/bash

# make sure our save file is there
SAVEFILE="/tmp/float_sav"
[[ ! -r $SAVEFILE ]] && touch $SAVEFILE

: << PYTHONCODE
# i used this for converting old presets to different resolution
def f(s):
    x,y,w,h = s.split(':')[2:]
    res_x_f = lambda _ : int((int(_)/old_x)*1600)
    res_y_f = lambda _ : int((int(_)/old_y)*2560)
    return "2560:1600:{}:{}:{}:{}".format(
        res_x_f(x), res_y_f(y),
        res_x_f(w), res_y_f(h)
    )
PYTHONCODE

: << OLDPRESETS
PRESETS=(
    # First preset - Assume this default size for all grids.
    "100:100:25:25:50:50"
    "100:100:60:8:34:42"    # top-right ish
    "100:100:5:8:34:42"     # top-left ish
    "100:100:5:55:34:42"    # bottom-left ish
    "100:100:29:9:42:82"    # centered (clean)
)
OLDPRESETS

PRESETS=(
    # First preset - Assume this default size for all grids.
    "2560:1600:400:640:800:1280"
    "2560:1600:960:204:544:1075"    # top-right ish
    "2560:1600:80:204:544:1075"     # top-left ish
    "2560:1600:80:1408:544:1075"    # bottom-left ish
    "2560:1600:463:230:672:2099"    # centered (clean)
)

get_win () {
    # need a letter - bash doesnt like only numeric varnames!
    echo "W""$(chunkc tiling::query -w id)"
}

ch_grid () {
    chunkc tiling::window --grid-layout "$1"
}

conduct_ch () {
    if ch_grid "$1"; then
        save_win_pos "$1"
    fi
}

get_win_pos () {
    source $SAVEFILE

    WIN_ID=$(get_win)
#    POS=$(grep -E "^${WIN_ID}=" $SAVEFILE 2>/dev/null)
#    POS=$(echo $POS | cut -f2- -d '=')
    POS=$(eval "echo \$$WIN_ID")

    if [[ -z "$POS" ]]; then
        # assume the window is focused with default coords
        echo "err: window isn't tracked yet. Returning first preset." >&2
        echo "${PRESETS[0]}"
    else
        echo $POS
    fi
}

save_win_pos () {
    WIN_ID=$(get_win)
    LINE="$WIN_ID=$1"
    LINE=$(echo $LINE)

    if grep "$WIN_ID" $SAVEFILE > /dev/null 2>&1; then
        gsed -i -e "s/$WIN_ID.*/$LINE/" $SAVEFILE
    else
        echo "$LINE" >> $SAVEFILE
    fi
}

get_pos () {
    LOC=$(get_win_pos)
    case "$1" in
        "my")
            echo "$LOC" | cut -f1 -d ':'
            ;;
        "mx")
            echo "$LOC" | cut -f2 -d ':'
            ;;
        "x")
            echo "$LOC" | cut -f3 -d ':'
            ;;
        "y")
            echo "$LOC" | cut -f4 -d ':'
            ;;
        "w")
            echo "$LOC" | cut -f5 -d ':'
            ;;
        "h")
            echo "$LOC" | cut -f6 -d ':'
            ;;
        *)
            exit 1
            ;;
    esac
}

ch_pos () {
    [[ -z "$3" ]] && LOC=$(get_win_pos) || LOC="$3"

    case "$1" in
        "x")
            lRET=$(echo "$LOC" | cut -f1-2 -d ':')
            lRET="$lRET:$2"
            rRET=$(echo "$LOC" | cut -f4- -d ':')
            echo "$lRET:$rRET"
            ;;
        "y")
            lRET=$(echo "$LOC" | cut -f1-3 -d ':')
            lRET="$lRET:$2"
            rRET=$(echo "$LOC" | cut -f5- -d ':')
            echo "$lRET:$rRET"
            ;;
        "w")
            lRET=$(echo "$LOC" | cut -f1-4 -d ':')
            lRET="$lRET:$2"
            rRET=$(echo "$LOC" | cut -f6- -d ':')
            echo "$lRET:$rRET"
            ;;
        "h")
            lRET=$(echo "$LOC" | cut -f1-5 -d ':')
            lRET="$lRET:$2"
            echo "$lRET"
            ;;
        *)
            exit 1
            ;;
    esac
}

preset () {
    if [[ $(chunkc tiling::query -w float) -eq 0 ]]; then
        chunkc tiling::window --toggle float
    else
        if [[ "$1" -eq 0 ]]; then
            # toggle floating off on "center" preset
            chunkc tiling::window --toggle float
            return 0
        fi
    fi

    POS=${PRESETS[$1]}
    if [[ -z "$POS" ]]; then exit 1; fi
    conduct_ch $POS
}

move () {
    if [[ -z "$2" ]]; then SIZE="50"; else SIZE="$2"; fi

    case "$1" in
        *x) dim_attr="x"; bound="$(get_pos mx)" ;;
        *y) dim_attr="y"; bound="$(get_pos my)" ;;
    esac

    dim=$(get_pos $dim_attr)

    # increment/decrement, bounds checking
    case "$1" in
        +*)
            dim=$(($dim+$SIZE))

            if [[ "$1" == "+x" ]]; then
                max_dim=$(get_pos w)
            else
                max_dim=$(get_pos h)
            fi
            if [[ $dim -gt $((bound-max_dim)) ]]; then dim=$((bound-max_dim)); fi
            ;;
        -*)
            dim=$(($dim-$SIZE))

            if [[ $dim -lt 0 ]]; then dim=0; fi
            ;;
    esac

    new_pos=$(ch_pos $dim_attr $dim)
    conduct_ch $new_pos
}

dilate () {
    if [[ -z "$3" ]]; then SIZE="50"; else SIZE="$3"; fi

    case "$2" in
        "w"|"e")
            dim1_attr="x"
            dim2_attr="w"
            bound="$(get_pos mx)"
            ;;
        "n"|"s")
            dim1_attr="y"
            dim2_attr="h"
            bound="$(get_pos my)"
            ;;
    esac

    dim1=$(get_pos $dim1_attr)
    dim2=$(get_pos $dim2_attr)

    case "$1" in
        --increase)
            if [[ "$2" == "w" || "$2" == "n" ]]; then
                dim1=$(($dim1-$SIZE))
            fi
            if [[ $dim1 -lt 0 ]]; then
                # dont change anything if we reach screen edge
                dim1=0
            else
                dim2=$(($dim2+$SIZE))

                if [[ $dim2 -gt $bound ]]; then dim2=$bound; fi
            fi
            ;;
        --decrease)
            if [[ "$2" == "w" || "$2" == "n" ]]; then
                dim1=$(($dim1+$SIZE))
            fi
            dim2=$(($dim2-$SIZE))
            ;;
    esac

    new_pos=$(ch_pos $dim1_attr $dim1 $(ch_pos $dim2_attr $dim2))
    conduct_ch $new_pos
}


usage () {
    scr_name=$(basename "$0")
    echo "Simple script to interface with chunkwm and allow movement/size changing of floating windows"
    echo "Usage:"
    echo "$scr_name get"
    echo "$scr_name preset [int]"
    echo "$scr_name move --increase|--decrease [xy] [num]"
    echo "$scr_name dilate --increase|--decrease [w|e|n|s] [num]"
}

key="$1"
shift
case "$key" in
    get)        get_win_pos                 ;;
    center)     conduct_ch "${PRESETS[1]}"  ;;
    preset)     preset "$1"                 ;;
    move)       move "$@"                   ;;
    dilate)     dilate "$@"                 ;;
    *)          usage                       ;;
esac
