# Amar Paul's .bash_profile
# Mac OS specific (i.e. specific to one computer)

# read .bashrc
[[ -r ~/.bashrc ]] && . ~/.bashrc

# and .profile
if [ -r ~/.profile ]; then . ~/.profile; fi

# and temporary aliases
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

# use `highlight' for colorized cat
ccat () { highlight -O xterm256 -i "$1" ;}

# alias for deluged (temporary until Transmission):
alias deluged="/Applications/Deluge.app/Contents/MacOS/deluged"

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
