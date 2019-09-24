# Amar's Dotfiles

##### Contents:
* [Shell](#shell)
* [Workflow](#workflow)
* [Window Manager](#wms)
  * [Browsers](#browsers)

Note - there are two branches in this repo (`master` for macOS, and `ubuntu` for linux)

Well these are my dotfiles. Most of these files are well-commented, so feel free to look through the repo.  
* Shell: the bulk of my aliases are in `.shell_aliases` (`zsh` and `bash` compatible!)
  * Shell: `zsh`
    * Plugin Manager: [antibody](https://getantibody.github.io/)
* Workflow:
  * [iTerm2 beta](https://www.iterm2.com/downloads.html) as my terminal emulator
  * [Neovim](https://github.com/neovim/neovim)
    * Plugin Manager: [dein](https://github.com/Shougo/dein.vim)
  * [Tmux](https://github.com/tmux/tmux)
  * [Pass](https://www.passwordstore.org/) for password management
* Window Management:
  * [chunkwm](https://github.com/koekeishiya/chunkwm/) and the hotkey daemon [khd](https://github.com/koekeishiya/khd)
  * [Uebersicht](http://tracesof.net/uebersicht/), a neat tool for the display of html/css/js widgets directly on the desktop. This program is managing the custom toolbar you might see in a lot of Mac OS rices (and mine!)
  * [Pywal](https://github.com/dylanaraps/pywal) like pretty much everyone else
* Miscellaneous:
  * various helper scripts in [.bin](.bin) and [.config/scripts/ricing.sh](.config/scripts/ricing.sh) for ricing or simple shell functions

<a name="shell"></a>
## Shell
Files: `.shell_aliases`, `.zshrc`, `.bashrc`, `.profile`, `.config/scripts/ricing.sh`
* `antibody` is used to manage plugins
* note for zsh users: `oh-my-zsh` has been (mostly) REMOVED from my dotfiles, since I see it as bloat.

Note on `bash`, `zsh`, and `fish`:  
`fish` and `zsh` are both great alternatives to `bash`. `zsh` is a superset of `bash` so you don't lose the knowledge of pure `bash` if you switch (important if you `ssh` a lot); `fish` isn't, but has better defaults so you don't *have* to configure it out-of-the-box.

<a name="workflow"></a>
## Workflow
Files:
* `.config/nvim/init.vim`
* `.tmux.conf`, `.tmux-osx.conf`

And check out my [.gitconfig](.gitconfig) for some helpful aliases. Most useful for me are the `alias`es for common commands like `commit`.

<a name="wms"></a>
## Window Management
Files (macOS and Ubuntu branches differ)
* `.khdrc`, `.chunkwmrc`
* `.config/ubersicht/widgets/*`

<a name="browsers"></a>
### Changes to browsers (Chrome and Firefox)
#### Userstyles, Extensions, Plugins, and Apps
##### userstyles/scripts
* [dark-gitlab-theme](https://userstyles.org/styles/164877/dark-gitlab-theme)
  * dark bg: `3c3836`
  * darker bg: `282828`
  * light text: `ebdbb2`
  * lighter text: `f1fbc7`
  * accent color: `98971a`
    * or `b8bb26` for lighter green?
* Chrome ([stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne) and [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Messenger Convo List Hover Toggle](http://userstyles.org/styles/120562)
  * [Messenger.com Dark](http://userstyles.org/styles/112722)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
  * [reddit - hide sidebar](https://userstyles.org/styles/142862/reddit-hide-sidebar-for-low-screen-width)
* Firefox (Stylus) and [GreaseMonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Reddit Slate Nights (Fixed, Custom Fork) - Dark](https://userstyles.org/styles/123908/reddit-slate-nights-fixed-custom-fork-dark)
  * [SOUNDCLOUD NIGHTMODE REIMAGINED](https://userstyles.org/styles/136523/soundcloud-nightmode-reimagined)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)

##### Extensions, Plugins, Apps
* Both:
  * uBlock Origin - opensource ad-blocking
  * Imagus - blow up images on mouseover
  * tampermonkey/greasemonkey - run custom js on specific webpages
  * browserpass - browser extension for `pass`, the unix password manager  
* Chrome:
  * Videostream - really underrated: an app that can easily chromecast any local video (regardless of codec)
  * Google Keep - note-taking
  * Pushbullet - sync messages between Android and laptop
  * Smile Always - redirect amazon.com to smile.amazon.com
* Firefox:
  * cliget (turns a link into a `curl` command with correct flags for cookies)
  * FireFTP
  * New Tab Tools (define tab keyboard shortcuts and a lot more)
  * Tab Mix Plus (this is run when Firefox starts)
  * checkCompatibility (for forcing old extension compatibility)
  * Prospector - OneLiner (turn navbar and tab bar into one line)
  * Flat Underline (for making my tabs look cool: not been updated for a long time, requires checkCompatibility)
