# Amar Paul's .bash_profile
# 	Login shells:							.bash_profile
#	nonlogin (i.e. open shell once in):		.bashrc
# On Mac (Terminal and iTerm2) all shells are login shells
# good explanation: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
# For Mac, file hierarchy is:
# .bash_profile > .bash_login > .profile 

# Source .bashrc for aliases and everything
[[ -r ~/.bashrc ]] && . ~/.bashrc

#### #### #### ####
# Change prompt: PS1 and pre/post command

# Helpful: http://blog.taylormcgann.com/tag/prompt-color/
#   white name, red directory
export PS1="\[\033[1;37m\]\u\[\033[1m\] : \[\033[1;31m\]\W\[\033[0m\] $ "

# hack for printing a newline after command but before output
# From: https://seasonofcode.com/posts/debug-trap-and-prompt_command-in-bash.html
# This will run before any command is executed.
function PreCommand() {
  if [ -z "$AT_PROMPT" ]; then
    return
  fi
  unset AT_PROMPT
  echo ""
}
trap "PreCommand" DEBUG

# This will run after the execution of the previous full command line.  We don't
# want it PostCommand to execute when first starting a bash session (i.e., at
# the first prompt).
FIRST_PROMPT=1
function PostCommand() {
  AT_PROMPT=1
  if [ -n "$FIRST_PROMPT" ]; then
    unset FIRST_PROMPT
    return
  fi
  echo ""
}
PROMPT_COMMAND="PostCommand"

# End of prompt changes
#### #### #### ####

###
# moar history
###
shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=9999
export HISTFILESIZE=100000

#### #### #### ####
# PATH and DYLD stuff go here for launchctl stuff (and other things probably)
# PATH and DYLD exports (lots of fixes)
# default PATH: /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

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
if [[ -d $HOME/Library/Android/sdk/platform-tools ]]; then
  export PATH="$PATH:""$HOME/Library/Android/sdk/platform-tools"
fi

###
# Temporarily stop Geant/Root stuff
# Temporarily stop Ubertooth stuff
: << 'END'

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

# Temporarily stop Ubertooth stuff
# Paths for Ubertooth One dynamic libs (libbtbb and libubertooth)
if [[ -d /Users/Amar/Ubertooth && 0 -eq 1 ]]; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/libbtbb-2015-10-R1/build/lib/src
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/ubertooth-2015-10-R1/host/build/libubertooth/src
fi

END

# End - PATH, DYLD fixes
#### #### #### ####

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
