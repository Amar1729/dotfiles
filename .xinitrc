# xinitrc
# after sourcing .xprofile, set up daemons (e.g. picom, dunst) and start window manager

[ -f ~/.xprofile ] && . ~/.xprofile

# try setting resolution here?
# nope! doesn't work ...
# idk where to set this damn resolution
#xrandr --output eDP-1 --mode 1920x1440

# consider adding this: switches off the monitor backlight when screen is locked (how lock?)
#xset dpms force off

sh ~/.fehbg

xflux -z 21230 &

#autocutsel -fork
autocutsel -selection PRIMARY -fork

# touch gestures
libinput-gestures-setup start

dunst &

# giview shows this as its own window
# xwinwrap just gets confused (hangs) on trying to display the gif
# NOTE - try this again since i forgot the ending ampersand
#/opt/src/xwinwrap/xwinwrap -fs -debug -- gifview --geometry 2880x1440 -a ~/Downloads/rainy-cafe.gif &

# really can't get this to work ...
#conky -c $HOME/.config/conky/conkyrc &

# ~dat sweet transparency~
picom -b --shadow --no-dnd-shadow --shadow-radius=30 --shadow-opacity=0.9

exec >>~/.xsession-errors 2>&1

# Here
# we
#   gooooooooo
exec bspwm -c $HOME/.config/bspwm/bspwmrc
