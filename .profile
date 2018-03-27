# Amar Paul's .profile

# I don't think this is as necessary for ubuntu ?

# using this for sourcing external scripts, exports, PATH changes

# Keep path fixes here: source from .bashrc or .zshrc separately

####
## PATH changes
####

# use this to fix if the path gets weird?
#DEFAULT_PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

# homebrew changes
[[ $(uname) == 'Darwin' ]] && \
[[ -n $DEFAULT_PATH ]] && \
	export PATH="/usr/local/sbin:/usr/local/bin:$DEFAULT_PATH" && \
	unset DEFAULT_PATH || \
	export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# my changes
export PATH="/opt/bin:$PATH"

# Add cargo (Rust) stuff
[[ -d $HOME/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d $HOME/.rvm/bin ]] && export PATH="$PATH:$HOME/.rvm/bin"

# keep this?
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

####
## interpreter stuff
####

# Python shell tab completion (use homebrew python)
which python3 >/dev/null && export PYTHONSTARTUP="$(`which python3` -m jedi repl)"

# Use fuck/thefuck for command correction
which thefuck >/dev/null && eval $(thefuck --alias)
