# Amar Paul's .bashrc
# 	Login shells:							.bash_profile
#	nonlogin (i.e. open shell once in):		.bashrc
# On Mac (Terminal and iTerm2) all shells are login shells
# good explanation: http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html
#
# For Mac, file hierarchy is:
# .bash_profile > .bash_login > .profile 
#
# This .bashrc is sourced from .bash_profile (wanted to keep everything together)

# read .profile
# avoid feedback loop! (if .profile sources us upon login shells)
# only source this if you modify it, take out the `. .bashrc`, and put pathfixes there (i.e. dont)
#[[ -r ~/.profile ]] && source ~/.profile

# shell aliases
[[ -r ~/.shell_aliases ]] && source ~/.shell_aliases

# and temporary aliases
[[ -r ~/.bash_aliases_tmp ]] && source ~/.bash_aliases_tmp

####
## bash-specific settings
####

# expand argument callbacks in shell with space (e.g. !![space])
bind Space:magic-space

####
## moar history plz
####

shopt -s histappend
export HISTCONTROL=ignoreboth
export HISTSIZE=9999
export HISTFILESIZE=100000

####
## Change prompt: PS1 and pre/post command
####

# Helpful: http://blog.taylormcgann.com/tag/prompt-color/
#   white name, red directory
export PS1="\[\033[1;37m\]\u\[\033[1m\] : \[\033[1;31m\]\W\[\033[0m\] $ "
# default ps1 on debian systems : somehow my escape codes can sometimes screw up terms?
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

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
