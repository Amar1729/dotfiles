# Amar Paul's .bashrc
# General stuff (put this on all of my *nix machines)

# When shell exits, append history
#shopt -s histappend

# Explicitly ignore commands starting with space and duplicates
#export HISTCONTROL=ignoreboth
#export HISTFILESIZE=100000

# Terminal Profile
# Helpful: http://blog.taylormcgann.com/tag/prompt-color/
# Old:
#   export PS1="\h:\W \u\$ "
export PS1="\n\[\033[1;37m\]\u\[\033[1m\] : \[\033[1;31m\]\W\[\033[0m\] $ "   # white name, red directory
# export PS1="\[\033[1;37m\]\u\[\033[1m\] : \[\033[1;32m\]\W\[\033[0m\] $ "

# My aliases:
alias ll="ls -lhFG"
alias la="ll -a"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# hack? for printing a newline after command but before output
# From: https://seasonofcode.com/posts/debug-trap-and-prompt_command-in-bash.html
# This will run before any command is executed.
function PreCommand() {
  if [ -z "$AT_PROMPT" ]; then
    return
  fi
  unset AT_PROMPT

  # Do stuff.
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

  # Do stuff.
  # echo "Running PostCommand"
}
PROMPT_COMMAND="PostCommand"

