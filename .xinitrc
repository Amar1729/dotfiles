# Amar Paul's xinitrc

xrdb ~/.Xresources
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

xflux -z 21230 &

export LANG="en_US.UTF-8"

# giview shows this as its own window
# xwinwrap just gets confused (hangs) on trying to display the gif
# NOTE - try this again since i forgot the ending ampersand
#/opt/src/xwinwrap/xwinwrap -fs -debug -- gifview --geometry 2880x1440 -a ~/Downloads/rainy-cafe.gif &

#conky -c $HOME/.config/conky/conkyrc &

exec >>~/.xsession-errors 2>&1

# I think this should be daemonized
urxvtd &

# Here
# we
#   gooooooooo
exec bspwm -c $HOME/.config/bspwm/bspwmrc
