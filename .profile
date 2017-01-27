# History stuff belongs in profile?
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=9999
export HISTFILESIZE=100000

# PATH and DYLD stuff go here for launchctl stuff (and other things probably)

# Sourced from .xinitrc

export PANEL_FIFO="/tmp/panel-fifo"

# always use nvim ?
alias vim="nvim"
alias vi="nvim"

################################################################
#### #### #### ####
#### #### #### ####
#
# PATH and DYLD exports (lots of fixes)

# Homebrew
export PATH=/usr/local/bin:$PATH

# fix Brew sbin problems
export PATH=/usr/local/sbin:$PATH

# Uncomment to use GNU utils without g prefix
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

# Virtualenv/VirtualenvWrapper
[[ -r /usr/local/bin/virtualenvwrapper.sh ]] && . /usr/local/bin/virtualenvwrapper.sh

# OpenCV 3.1.0 Support (Installed view homebrew, bound to Python 2.7)
if [[ -d /usr/local/Cellar/opencv3 ]]; then
    export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/Cellar/opencv3/3.1.0/lib:$DYLD_FALLBACK_LIBRARY_PATH 
    export PYTHONPATH=/usr/local/Cellar/opencv3/3.1.0/lib/python2.7/site-packages:$PYTHONPATH
fi

# For using matplotlib instide virtualenv
# Inside (env), run: $ frameworkpython
function frameworkpython {
    if [[ ! -z "$VIRTUAL_ENV" ]]; then
        PYTHONHOME=$VIRTUAL_ENV /usr/local/bin/python "$@"
    else
        /usr/local/bin/python "$@"
    fi
}

# path for adb (Android Studio 1.0.xx)
[[ -d $HOME/Library/Android/sdk/platform-tools ]] && export PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"

# Temporarily stop Geant/Root stuff (can we brew install them?)
if [[ -d /Users/Amar/Desktop/Projects/Coutu && 0 -eq 1 ]]; then
	# Path modifications for Geant4
	export G4INSTALL='/Users/Amar/Desktop/Projects/Coutu/geant4.10.2-install'
	source $G4INSTALL/bin/geant4.sh

	# Path modifications for Root
	export ROOT='/Users/Amar/Desktop/Projects/Coutu/root'
	export PATH=$PATH:"/Users/Amar/Desktop/Projects/Coutu/root/bin"
	export LD_LIBRARY_PATH="/Users/Amar/Desktop/Projects/Coutu/root/lib"
	source /Users/Amar/Desktop/Projects/Coutu/root/bin/thisroot.sh
fi

# Temporarily stop Ubertooth stuff (tbh don't need it after Aug 2016 [triggered o_O])
# Paths for Ubertooth One dynamic libs (libbtbb and libubertooth)
if [[ -d /Users/Amar/Ubertooth && 0 -eq 1 ]]; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/libbtbb-2015-10-R1/build/lib/src
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/ubertooth-2015-10-R1/host/build/libubertooth/src
fi

#### #### #### ####
#### #### #### #### End - PATH, DYLD fixes
################################################################
