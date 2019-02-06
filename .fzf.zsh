# Setup fzf
# ---------
# (fzf installed into /usr/bin on arch, so this is unecessary)
#if [[ ! "$PATH" == */usr/bin* ]]; then
#    export PATH="$PATH:/usr/bin"
#fi

PREFIX=/usr/share/fzf

# Auto-completion
# ---------------
[[ $- == *i* ]] && \
    [[ -f $PREFIX/completion.zsh ]] && source "$PREFIX/completion.zsh" 2>/dev/null

# Key bindings
# ------------
[[ -f $PREFIX/key-bindings.zsh ]] && source "$PREFIX/key-bindings.zsh"
