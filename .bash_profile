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
