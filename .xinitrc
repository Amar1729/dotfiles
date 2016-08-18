# Amar Paul's xinitrc

cd $HOME
# source $HOME/.profile

# For i3?
# From: https://github.com/lukeluo/linux-debian7-admin/blob/master/archlinux/home/luke/.xinitrc
#if [ -d /usr/X11/lib/X11/xinit/xinitrc.d ]; then
#  for f in /usr/X11/lib/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

#xrdb ~/.Xresources
#xset +fp ~/.fonts
#xset fp rehash
#xset -b
#xsetroot -cursor_name left_ptr
# Set up modmap for Apple keyboard (Cmd is not really named super?)
xmodmap ~/.Xmodmap

export LANG="en_US.UTF-8"

exec >>~/.xsession-errors 2>&1

sxhkd -c $HOME/.config/sxhkd/sxhkdrc &

# Start off with a terminal I guess (~default)
urxvt &
# I think this should be daemonized
# urxvtd &

# Here
# we
#   gooooooooo
exec bspwm -c $HOME/.config/bspwm/bspwmrc
#exec i3 -c $HOME/.config/i3/config
