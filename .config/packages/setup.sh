#! /usr/bin/env

# install stuff on a system depending on what pkg managers we have installed

# use https for initial read-only remote for clone
REPO_HTTPS="https://github.com/Amar1729.git"
REPO_GIT="git@github.com:Amar1729/dotfiles"

git_setup () {
    # make sure amar1729/dotfiles is cloned to $HOME
    # git clone https://github.com/Amar1729.git

    pushd ~/

    if [[ -d .git ]]; then
        echo "Already a git directory. Stopping." >&2
        return 1
    fi

    git init
    git remote add origin "$REPO_HTTPS"
    git fetch --all
    git checkout -t origin/master

    git remote remove origin
    git remote add origin "$REPO_GIT"
    git fetch --all

    popd
}

pre_package () {
    # init various system things

    # make sure ssh is here:
    mkdir -p ~/.ssh/
    echo "make sure to run ssh-keygen"
}

mac () {
    # on a mac system, install and use homebrew

    # setup dev environ
    xcode-select install

    # get Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brew update

    # some base deps that are useful everywhere
    brew install git binutils coreutils findutils
    brew install python
    brew install zsh getantibody/tap/antibody neovim tmux

    # install everything from my list of packages (this will also auto-tap repos!)
    if [[ -f ./brew.txt ]]; then
        cat ./brew.txt | xargs brew install
    fi

    # important defaults cmds
    # hide icons on the desktop:
    defaults write com.apple.finder CreateDesktop true
    defaults write org.macosforge.xquartz.X11 app_to_run /usr/local/bin/urxvt
    defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
    defaults write com.apple.dock no-bouncing -bool TRUE
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool NO
}

_linux () {
    if command -v apt &>/dev/null; then
        # ubuntu

        # (not in apt)
        curl -sfL git.io/antibody | sh -s - -b /usr/local/bin

        sudo -v

        # FUCK software updater
        systemctl disable --now apt-daily{,-upgrade}.{timer,service}

        # ---- add any repositories necessary ----

        # theming (i don't always use these)
        # sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/arc-theme.list"
        # wget http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key
        # sudo apt-key add - < Release.key
        # # Arc theme
        # sudo apt-get install arc-theme unity-tweak-tool

        # nvim
        sudo add-apt-repository ppa:neovim-ppa/stable

        # ---- ----

        sudo apt update

        # window mgmt
        sudo apt install -y bspwm sxhkd

        # devel
        sudo apt install -y zsh tmux python3-devel python3-pip

        sudo apt install -y neovim || sudo apt install -y vim-nox

        if [[ -f ./apt.txt ]]; then
            cat ./apt.txt | xargs sudo apt install -y
        fi
    elif command -v pacman >/dev/null; then
        # archlinux
        # TODO
        true
    fi

    # snippet for installing a font:
    # tar FantasqueSansMono.tar.gz -C ~/.fonts/Fantasque
    # fc-cache -f -v
}

post_package () {
    # install a couple other things

    set -e

    # zsh+antibody
    if command -v antibody; then
        antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh
    else
        echo "antibody not found in PATH!" >&2
    fi

    # python stuff
    python3 -m pip install --user pipx
    if [[ -f ./pipx.txt ]]; then
        cat ./pipx.txt | xargs -n1 pipx install
    fi

    # neovim+dein
    mkdir -p ~/.config/nvim/
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/.config/nvim/installer.sh
	sh ~/.config/nvim/installer.sh "$HOME/.cache"
}

main () {
    # do all the platform-agnostic stuff here, and call individual pkg mgmt systems

    pre_package

    # different systems should guarantee install of zsh, tmux, python3, pip3
    if [[ "$(uname -s)" == "Darwin" ]]; then
        _mac

        echo "ensure installation of various oother things:"
        echo "* FantasqueSansMono font"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        _linux
    fi

    post_package
}

# this ensures my dotfiles repo is cloned to $HOME
# (not always necessary)
if [[ "$1" == "--full" ]]; then
    git_setup
fi

main
