# Amar Paul's .bash_profile
# Mac OS specific (i.e. specific to one computer)

# Also read .bashrc
[[ -r ~/.bashrc ]] && . ~/.bashrc

# If it's there, read the temporary aliases
[[ -r ~/.bash_aliases_tmp ]] && . ~/.bash_aliases_tmp

# very rudimentary rename (or syntax for it)
#	for f in Game.of.Thrones.S03E*
#	 do
#	  new=${f/Game.of.Thrones./}
#	  new=${new/720p*/srt}
#	  mv $f $new
#	 done

# Open different Terminal windows
alias redsand="open ~/.terminal_profiles/Red\ Sands.terminal"
alias zenburn="open ~/.terminal_profiles/Zenburn.terminal"
alias soldark="open ~/.terminal_profiles/Solarized\ Dark\ ansi.terminal"
alias solit="open ~/.terminal_profiles/Solarized\ Light\ ansi.terminal"
alias novel="open ~/.terminal_profiles/Novel.terminal"

# Just make a function lol (uses global IP for safety?)
# This function doesn't accept wildcards
torrent () { scp "$1" pi@bass2000.ddns.net:/home/pi/deluge/"$2" ;}

# Usually I want to open files in a new window
alias subl="subl -n"

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
if [[ -f /usr/local/bin/virtualenvwrapper.sh ]]; then
	source /usr/local/bin/virtualenvwrapper.sh
fi

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
export PATH=$PATH:$HOME"/Library/Android/sdk/platform-tools"

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

################################################################
#### #### #### ####
#### #### #### ####
#
# Following modifications are from:
# http://natelandau.com/my-mac-osx-bash_profile/

#   ---------------------------------------
#   General
#   ---------------------------------------
# mcd:          Makes new Dir and jumps inside
#   I'm having second thoughts about whether this should use '-p' ?
mcd () { mkdir -p "$1" && cd "$1"; }

# Prevent power button from immediately sleeping display (fuck Dimoff)
alias PowerSleepOff='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool no'
alias PowerSleepOn='defaults write com.apple.loginwindow PowerButtonSleepsSystem -bool yes'

# Move default screencap location
# Where I want them saved:
alias picDls='defaults write com.apple.screencapture location ~/Downloads/; killall SystemUIServer'
# Actual default:
alias picDef='defaults write com.apple.screencapture location ~/Desktop/; killall SystemUIServer'

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#### #### #### ####
#### #### #### #### End - Nate Landau's suggestions
################################################################
