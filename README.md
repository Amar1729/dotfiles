# Amar's Dotfiles

```
sh -c "$(curl -fsLS git.io/chezmoi)" -- init --apply Amar1729
```

These dotfiles are managed by [`chezmoi`](https://github.com/twpayne/chezmoi/). I used to use git manually, but tracking changes across multiple branches for different operating systems/flavors became a huge pain once I was frequently cherry-picking and tagging to avoid merging. See the homepage for more details!

One benefit of `chezmoi` is that this repo - the "source state" - is managed directly renaming certain files in a specific way. "Dot" files (such as `.bashrc`) in the target state are named as `dot_bashrc` in the source state.

Another benefit is that all files can be managed in one branch, using `chezmoi`'s [template logic](https://github.com/twpayne/chezmoi/blob/master/docs/HOWTO.md#manage-machine-to-machine-differences). So files for both macOS/linux are kept in the default branch of this repo, and synced into the "target state" (your home directory) based on the value of variables from `chezmoi data` - such as `.chezmoi.os` - or the settings in [`.chezmoiignore`](./.chezmoiignore).


## Miscellaneous

* [atuin](https://atuin.sh)
* [fzf](https://github.com/junegunn/fzf)
* [fd](https://github.com/sharkdp/fd)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [pywal](https://github.com/dylanaraps/pywal)


## Window Management

* [`.skhdrc`](./dot_skhdrc)
* [`.yabairc`](./executable_dot_yabairc)
* [`.config/ubersicht/widgets/`](./dot_config/ubersicht/widgets/)

### macOS

* [yabai](https://github.com/koekeishiya/yabai/) and the hotkey daemon [`skhd`](https://github.com/koekeishiya/skhd)
  * [Uebersicht](http://tracesof.net/uebersicht/), a neat tool for the display of html/css/js widgets directly on the desktop. This program is managing the custom toolbar you might see in a lot of Mac OS rices (and mine!)

### linux

< todo: bspwm/sxhkd/conky >


## Shell

* `atuin` for syncing/backing up shell history, as well as granular searching of history
* [`.zshrc`](./dot_zshrc)
* [`.zsh_plugins.txt`](./dot_zsh_plugins.txt)
* [`.profile`](./dot_profile)
* [`.shell_aliases`](./dot_shell_aliases.tmpl)
* [fzf bindings](./dot_config/fzf)

`zsh` plugins are managed by [antibody](https://getantibody.github.io/):
```
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.zsh
```

Most shell aliases are in `.shell_aliases` and are `zsh`/`bash`-compatible.

I also use a repository of small scripts I write myself: [bin](https://github.com/Amar1729/bin).


## Terminal Emulator
* [kitty](https://github.com/kovidgoyal/kitty)
* [alacritty](https://github.com/alacritty/alacritty/)


## Workflow

* [Neovim](https://github.com/neovim/neovim), with [my config](./dot_config/nvim)
  * Plugin manager: [lazy](https://github.com/folke/lazy.nvim)
* [Tmux](https://github.com/tmux/tmux), with my [`.tmux.conf`](./dot_tmux.conf.tmpl)
* Git, with my [`.gitconfig`](./dot_gitconfig.tmpl)
* [Pass](https://www.passwordstore.org/) for password management


## Browsers

#### Userstyles, Extensions, Plugins, and Apps

##### userstyles/scripts
* [dark-gitlab-theme](https://userstyles.org/styles/164877/dark-gitlab-theme)
  * dark bg: `3c3836`
  * darker bg: `282828`
  * light text: `ebdbb2`
  * lighter text: `f1fbc7`
  * accent color: `98971a`
    * or `b8bb26` for lighter green?
* Firefox (Stylus) and [GreaseMonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/))

  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
  * [reddit - hide sidebar](https://userstyles.org/styles/142862/reddit-hide-sidebar-for-low-screen-width)

  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Reddit Slate Nights (Fixed, Custom Fork) - Dark](https://userstyles.org/styles/123908/reddit-slate-nights-fixed-custom-fork-dark)
  * [SOUNDCLOUD NIGHTMODE REIMAGINED](https://userstyles.org/styles/136523/soundcloud-nightmode-reimagined)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)

##### Extensions, Plugins, Apps
  * [nightTab](https://addons.mozilla.org/en-US/firefox/addon/nighttab/) - really nice homepage
  * [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) - opensource ad-blocking
  * Imagus - blow up images on mouseover
  * tampermonkey/greasemonkey - run custom js on specific webpages
  * browserpass - browser extension for `pass`, the unix password manager  
  * Pushbullet - sync messages between Android and laptop
  * cliget (turns a link into a `curl` command with correct flags for cookies)
