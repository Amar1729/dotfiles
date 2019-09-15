# Amar Paul's .profile
# using this for sourcing external scripts, exports, PATH changes

#    
#export EDITOR_LOOK="carot"
# ▏▎▍▌▋▊▉█
export EDITOR_LOOK="block"

# Keep path fixes here: source from .bashrc or .zshrc separately

# try to use pinentry-ncurses in terminal, pinentry-mac otherwise?
GPG_TTY=$(tty)
export GPG_TTY

####
## PATH changes
####

# use this to fix if the path gets weird?
#DEFAULT_PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

# homebrew changes
export HOMEBREW_NO_AUTO_UPDATE=1
[[ $(uname) == 'Darwin' ]] && \
[[ -n $DEFAULT_PATH ]] && \
	export PATH="/usr/local/sbin:/usr/local/bin:$DEFAULT_PATH" && \
	unset DEFAULT_PATH || \
	export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# add snap path on ubuntu
[[ -d /snap/bin ]] && emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

# my changes
export PATH="$PATH:/opt/bin:$HOME/.bin"

[[ -d ~/.local/bin ]] && export PATH="$PATH:$HOME/.local/bin"

# add pip user installs
#export PATH="$PATH:$HOME/Library/Python/3.7/bin"
export PATH="$PATH:$HOME/.local/bin"

# add fzf
if [[ -n "$ZSH" ]]; then
    # for now - unfortunately, this hack is required to stop
    # lightdm's Xsession wrapper from sourcing us and incorrectly
    # trying to source zsh bindings. it'll fail, and lightdm won't
    # correctly start up X.
    # (currently, $ZSH is set inside my .zshrc)
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# Add cargo (Rust) stuff
[[ -d $HOME/.cargo/bin ]] && export PATH="$HOME/.cargo/bin:$PATH"

# use sccache
export RUSTC_WRAPPER=$HOME/.cargo/bin/sccache

# go stuff
# export GOPATH="${HOME}/.go"
# export GOROOT=/usr/local/opt/go/libexec
# export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# nix
# arch pkg: had to manually create user profile:
# ln -s /nix/var/nix/profiles/default/ /nix/var/nix/profiles/per-user/$USER/profile
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
	. ~/.nix-profile/etc/profile.d/nix.sh;
fi

# perl
#export PATH="$HOME/perl5/bin:$PATH"
#export PERL5LIB="$HOME/perl5/lib/perl5:$PERL5LIB"
#export PERL_LOCAL_LIB_ROOT="$HOME/perl5:$PERL_LOCAL_LIB_ROOT"
#export PERL_MB_OPT="--install_base \"$HOME/perl5\""
#export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -d $HOME/.rvm/bin ]] && export PATH="$PATH:$HOME/.rvm/bin"

# keep this?
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

# add bundled gems
[[ -d $HOME/.local/rubygems ]] && export PATH="$PATH:$HOME/.local/rubygems"

# java helper script (manage sdks)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# why doesnt this work
alias mvn="~/.sdkman/candidates/maven/3.5.4/bin/mvn"

# add calibre cli
[[ -d /Applications/calibre.app ]] && \
export PATH="$PATH:/Applications/calibre.app/Contents/console.app/Contents/MacOS/"

# mypy lxml stubs (static type analysis for python)
export MYPYPATH="$HOME/.cache/mypy/lxml-stubs"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# comment out the rest of this, but keep it around?
: << 'END'

# old path/dyld/etc stuff (from .bash_profile)
####
# PATH and DYLD stuff go here for launchctl stuff (and other things probably)
# PATH and DYLD exports (lots of fixes)

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

# Geant/Root stuff (can we brew install them?)
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

# Ubertooth stuff
# Paths for Ubertooth One dynamic libs (libbtbb and libubertooth)
if [[ -d /Users/Amar/Ubertooth && 0 -eq 1 ]]; then
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/libbtbb-2015-10-R1/build/lib/src
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/Users/Amar/Ubertooth/ubertooth-2015-10-R1/host/build/libubertooth/src
fi

END

# https://silvae86.github.io/sysadmin/mac/osx/mojave/beta/libxml2/2018/07/05/fixing-missing-headers-for-homebrew-in-mac-osx-mojave/
# fix missing headers on osx (e.g. libxml)
#sudo installer -pkg /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg -target /
