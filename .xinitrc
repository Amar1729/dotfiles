cd $HOME
# source $HOME/.profile
export LANG="en_US.UTF-8"
exec >>~/.xsession-errors 2>&1
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &

urxvt &

exec bspwm -c $HOME/.config/bspwm/bspwmrc
