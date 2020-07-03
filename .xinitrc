# Amar Paul's xinitrc

xrdb ~/.Xresources
# note - i have some rebindings e.g. caps lock -> escape here.
# these obviously will only work inside x sessions; use loadkeys
# for rebinding system-wide (e.g. a multi-user.terminal?)
xmodmap ~/.Xmodmap
sh ~/.fehbg

#xset +fp ~/.fonts
    # https://github.com/sunaku/tamzen-font
    #xset +fp ~/.fonts/tamzen-font/bdf/
    #xset +fp ~/.fonts/tamzen-font/dfont/
#xset fp rehash
#xset -b
#xsetroot -cursor_name left_ptr

# try setting resolution here?
# nope! doesn't work ...
# idk where to set this damn resolution
#xrandr --output eDP-1 --mode 1920x1440

# consider adding this: switches off the monitor backlight when screen is locked (how lock?)
#xset dpms force off

xflux -z 21230 &

export LANG="en_US.UTF-8"

# giview shows this as its own window
# xwinwrap just gets confused (hangs) on trying to display the gif
# NOTE - try this again since i forgot the ending ampersand
#/opt/src/xwinwrap/xwinwrap -fs -debug -- gifview --geometry 2880x1440 -a ~/Downloads/rainy-cafe.gif &

# really can't get this to work ...
#conky -c $HOME/.config/conky/conkyrc &

# ~dat sweet transparency~
compton -b --shadow --no-dnd-shadow --shadow-radius=30 --shadow-opacity=0.9

#autocutsel -fork
autocutsel -selection PRIMARY -fork

# touch gestures
libinput-gestures-setup start

exec >>~/.xsession-errors 2>&1

# I think this should be daemonized
urxvtd &

# Here
# we
#   gooooooooo
exec bspwm -c $HOME/.config/bspwm/bspwmrc
