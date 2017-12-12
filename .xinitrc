# Amar Paul's xinitrc

xrdb ~/.Xresources
sh ~/.fehbg

#xset +fp ~/.fonts
    # https://github.com/sunaku/tamzen-font
    #xset +fp ~/.fonts/tamzen-font/bdf/
    #xset +fp ~/.fonts/tamzen-font/dfont/
#xset fp rehash
xset -b
xsetroot -cursor_name left_ptr

export LANG="en_US.UTF-8"

exec >>~/.xsession-errors 2>&1

# urxvt isn't working (the fonts defn'd by Xresources aren't quite right for urxvt yet)
# Start off with a terminal I guess (~default)
#urxvt &
# I think this should be daemonized
urxvtd &
#xterm &

# Here
# we
#   gooooooooo
exec bspwm -c $HOME/.config/bspwm/bspwmrc
