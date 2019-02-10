#!/bin/bash

# Use imagemagick to add some text to a wallpaper
# useful for setting a dramatic login wp

output=login-bg.jpg

hack () {
echo "         __             __  _                __               __   _                _           _____"
echo "   _____/ /_____ ______/ /_(_)___  ____ _   / /_  ____ ______/ /__(_)___  ____ _   (_)___  _    |__  /"
echo "  / ___/ __/ __ \`/ ___/ __/ / __ \/ __ \`/  / __ \/ __ \`/ ___/ //_/ / __ \/ __ \`/  / / __ \(_)    /_ < "
echo " (__  ) /_/ /_/ / /  / /_/ / / / / /_/ /  / / / / /_/ / /__/ ,< / / / / / /_/ /  / / / / /     ___/ / "
echo "/____/\__/\__,_/_/   \__/_/_/ /_/\__, /  /_/ /_/\__,_/\___/_/|_/_/_/ /_/\__, /  /_/_/ /_(_)   /____/  "
echo "                                /____/                                 /____/                         "
}

dims () {
    # draw the text halfway across the picture, 3/4 of the way down
    dim=$(identify $1 | grep -o "[0-9]\+x[0-9]\+ ")
    width=$(echo "${dim%x*} / 2" | bc)
    height=$(echo "${dim#*x} * 3 / 4" | bc)
    echo "${width},${height}"
}

convert -font "Iosevka-Heavy" -pointsize 25 -fill white -draw "text $(dims $1) \" `hack` \"" $1 $output

echo "Generated: ${output}"
echo "Make sure to move file into proper location e.g. /usr/share/pixmaps/ for lightdm"
