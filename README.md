# Amar's Dotfiles

##### Contents:
* [Shell](#shell)
* [Workflow](#workflow)
* [Window Manager](#wms)
  * [Browsers](#browsers)

Note - there are two branches in this repo (`master` for macOS, and `ubuntu`)

Well these are my dotfiles. Most of these files are well-commented, so feel free to look through the repo.  
* Shell: the bulk of my aliases are in `.shell_aliases` (`zsh` and `bash` compatible!)
  * Using `zsh` with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) and [antigen](https://github.com/zsh-users/antigen) for plugins and plugin management, respectively
* Workflow:
  * [iTerm2 beta](https://www.iterm2.com/downloads.html) as my terminal emulator
  * [Neovim](https://github.com/neovim/neovim) (using [dein](https://github.com/Shougo/dein.vim) as a plugin manager)
  * [Tmux](https://github.com/tmux/tmux)
  * Sublime Text with [Package Control](https://packagecontrol.io/) - I only really use this for LaTeX or website development
* Window Management:
  * [kwm](https://github.com/koekeishiya/kwm) (obsolete!) and the hotkey daemon [khd](https://github.com/koekeishiya/khd)
  * TODO - soon will switch to [chunkwm](https://github.com/koekeishiya/chunkwm/)
  * [Uebersicht](http://tracesof.net/uebersicht/), a neat tool for the display of html/css/js widgets directly on the desktop. This program is managing the custom toolbar you might see in a lot of Mac OS rices (and mine!)
  * [Pywal](https://github.com/dylanaraps/pywal) like pretty much everyone else
* Miscellaneous:
  * some ricing scripts in [.config/scripts/ricing.sh](.config/scripts/ricing.sh) for functions like changing the wallpaper

<a name="shell"></a>
## Shell
Files: `.shell_aliases`, `.zshrc`, `.bashrc`, `.profile`, `.config/scripts/ricing.sh`
* `oh-my-zsh` is used to add plugins; `antigen` is used to easily mange those plugins. They can both be installed easily, and further setup is simple.

Note on `bash`, `zsh`, and `fish`:  
`fish` and `zsh` are both great alternatives to `bash`. `zsh` is a superset of `bash` so you don't lose the knowledge of pure `bash` if you switch (important if you `ssh` a lot); `fish` isn't, but has better defaults so you don't *have* to configure it out-of-the-box.

<a name="workflow"></a>
## Workflow
Files:
* `.config/nvim/init.vim`
* `.tmux.conf`, `.tmux-osx.conf`
* `.config/sublime 3/*`

And check out my [.gitconfig](.gitconfig) for some helpful aliases. Most useful for me are `core.excludesfile` and the `alias`es for common commands like `commit`.

<a name="wms"></a>
## Window Management
Files (macOS and Ubuntu branches differ)
* `.khd`, `.kwm/kwmrc`
* `.config/ubersicht/widgets/*`

<a name="browsers"></a>
### Changes to browsers (Chrome and Firefox)
#### Userstyles, Extensions, Plugins, and Apps
##### userstyles/scripts
* Chrome ([stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne) and [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Messenger Convo List Hover Toggle](http://userstyles.org/styles/120562)
  * [Messenger.com Dark](http://userstyles.org/styles/112722)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
  * [reddit - hide sidebar](https://userstyles.org/styles/142862/reddit-hide-sidebar-for-low-screen-width)
* Firefox ([Stylish](https://addons.mozilla.org/en-US/firefox/addon/stylish/) and [GreaseMonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Reddit Slate Nights (Fixed, Custom Fork) - Dark](https://userstyles.org/styles/123908/reddit-slate-nights-fixed-custom-fork-dark)
  * [SOUNDCLOUD NIGHTMODE REIMAGINED](https://userstyles.org/styles/136523/soundcloud-nightmode-reimagined)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
  * [Youtube Dark Style](https://userstyles.org/styles/116675/youtube-dark-style)

##### Extensions, Plugins, Apps
TODO:
* Both:
  * uBlock Origin
  * Imagus (very helpful)
  * tampermonkey/stylus (chrome) / greasemonkey/stylish (firefox)
* Chrome:
	* browserpass
	* dropbox for gmail
	* Google Hangouts
	* Google Keep
	* Google Play Music
	* MagiCSS - Live CSS Editor
	* Pushbullet
	* Smile Always (redirect amazon.com to smile.amazon.com)
	* SoundCloud Downloader Free
	* Videostream
	* Vimium (don't use since I have `khd` bindings)
	* Web of Trust - Website Rankings
* Firefox:
  * Extensions:
	* uBlock Origin
	* checkCompatibility (for forcing old extension compatibility)
	* cliget (turns a link into a `curl` command with correct flags for cookies)
	* colorPicker (great eyedropper)
	* CurrentSong (obsolete in Firefox Quantum :/)
	* FireFTP
	* Prospector - OneLiner (turn navbar and tab bar into one line)
	* New Tab Tools (define tab keyboard shortcuts and a lot more)
	* Stylish
	* Tab Mix Plus (this is run when Firefox starts)
  * Appearance:
    * Flat Underline (for making my tabs look cool: not been updated for a long time, requires checkCompatibility)


