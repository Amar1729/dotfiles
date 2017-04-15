# Amar's Dotfiles

##### Quick Reference - Changes to:
* [Shell](#shell)
* [Workflow](#workflow)
* [Window Manager](#wms)
* [Misc](#misc)
  * [Browsers](#browsers)

After lots of work customizing quite a few different tools, these are my dotfiles! Some are Mac-specific, but most of them will work on Linux too. This is the stuff I've included (with explanation mostly in comments in the files but also some below):  
* Shell:
  * Currently using `zsh` and it's great! check out my [.zshrc](.zshrc).
	* using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/) for managing the `zsh` config, and
    * using [Antigen](https://github.com/zsh-users/antigen) as a plugin manager
  * was using `bash` until recently: config for this is mostly in [.bashrc](.bashrc), [.bash_profile](.bash_profile), and [.profile](.profile)
* Workflow:
  * [iTerm2 beta](https://www.iterm2.com/downloads.html) as my terminal emulator
  * [Neovim](https://github.com/neovim/neovim) (using [dein](https://github.com/Shougo/dein.vim) as a plugin manager)
  * [Tmux](https://github.com/tmux/tmux)
  * Sublime Text (using [Package Control](https://packagecontrol.io/) as a package manager). This one is here more for backup of files, since I don't use sublime a lot for coding anymore
* Window Management:
  * The wonderful Mac tiling WM [kwm](https://github.com/koekeishiya/kwm) and hotkey daemon [khd](https://github.com/koekeishiya/khd)
  * [Uebersicht](http://tracesof.net/uebersicht/), a neat tool for the display of html/css/js widgets directly on the desktop. This program is managing the custom toolbar you might see in a lot of Mac OS rices (and mine!)
  * [Themer](https://github.com/s-ol/themer) for generation of colorschemes from wallpapers
  * (old) [bspwm](https://github.com/baskerville/bspwm) and its daemon [sxhkd](https://github.com/baskerville/sxhkd). I used this WM for a little while, but it needs to be run in an X window system - provided by XQuartz on Mac, which only handles terminal windows. I switched to `kwm` since it interfaces directly with Mac syscalls to manage all applications rather than needing XQuartz.
* Miscellaneous:
  * some ricing scripts in .config/scripts/ricing.sh for functions like changing the wallpaper
  * .Xmodmap, .Xresources, .Xdefaults, .xinitrc leftover from playing around with XQuartz

<a name="shell"></a>
## Shell
Files: `.zshrc`, `.bashrc`, `.bash_profile`, `.profile`, (although `.profile` also deals with some leftover stuff from using `bspwm`) `.config/scripts/ricing.sh`
* zsh config is a bit of a hassle and oh-my-zsh doesn't scale well, so `antigen` is used to easily manage plugins
* If you don't want to spend too much time on shell configuration, `fish` is a good alternative shell to `bash`, similar to `zsh` but with a lot of sane defaults built in.
* Some of my `bash`-defined functions are sourced by `zshrc` since I haven't fully moved over yet (normally this isn't great practice)

<a name="workflow"></a>
## Workflow
Files:
* `.config/nvim/init.vim`
* `.tmux.conf`, `.tmux-osx.conf`
* `.config/sublime 3/*`

<a name="wms"></a>
## Window Management
Files:
* `.khd` and `.kwm/kwmrc`
* `.config/ubersicht/widgets/*`
* `.config/themer/*` (these are where the generated themes are written)
* `.config/bspwm/bspwmrc` and `.config/sxhkd/sxhkdrc`

<a name="misc"></a>
## Misc
### misc scripts
Files: `.config/scripts/*`

### xfiles (haha)
Files: `.Xmodmap`, `.Xresources`, `.xinitrc`

### Changes to your .gitconfig:
You can make these edits by running `git config -e` or manually editing `~/.gitconfig`.  
* Make sure to have a global gitignore file (for all those pesky compiled .o files and python virtualenvs and whatever else)
* There are a few helpful aliases git allows you to make. I'm using fairly standard ones, shown below
```
[core]
	excludesfile = /Users/Amar/.gitignore_global
[alias]
	co = checkout
	ci = commit
	st = status
	br = branch
	hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
```

<a name="browsers"></a>
### Changes to browsers (Chrome and Firefox): Userstyles, Extensions, Plugins, and Apps
#### userstyles/scripts
* Chrome ([stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne) and [Tampermonkey](https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo?hl=en))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Messenger Convo List Hover Toggle](http://userstyles.org/styles/120562)
  * [Messenger.com Dark](http://userstyles.org/styles/112722)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
* Firefox ([Stylish](https://addons.mozilla.org/en-US/firefox/addon/stylish/) and [GreaseMonkey](https://addons.mozilla.org/en-US/firefox/addon/greasemonkey/))
  * [Github Dark Wide Transparent](https://userstyles.org/styles/126131/github-dark-wide-transparent)
  * [Reddit Slate Nights (Fixed, Custom Fork) - Dark](https://userstyles.org/styles/123908/reddit-slate-nights-fixed-custom-fork-dark)
  * [SOUNDCLOUD NIGHTMODE REIMAGINED](https://userstyles.org/styles/136523/soundcloud-nightmode-reimagined)
  * [userstyles.org - blue custom](https://userstyles.org/styles/118410/userstyles-org-blue-custom)
  * [Youtube Dark Style](https://userstyles.org/styles/116675/youtube-dark-style)

#### Extensions, Plugins, Apps
TODO:
* Both:
  * Adblock Plus
  * Imagus (very helpful)
  * tampermonkey/stylus (chrome) / greasemonkey/stylish (firefox)
  * IITC: Ingress Intel Map Total Conversion
  * Dashlane
* Chrome:
	* dashlane (KeePass also good - local storage)
	* dropbox for gmail
	* eyedropper (not great)
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
	* Adblock Plus
	* checkCompatibility (for forcing old extension compatibility)
	* cliget (turns a link into a `curl` command with correct flags for cookies)
	* colorPicker (great eyedropper)
	* CurrentSong
	* FireFTP
	* Prospector - OneLiner (turn navbar and tab bar into one line)
	* New Tab Tools (define tab keyboard shortcuts and a lot more)
	* Stylish
	* Tab Mix Plus (this is run when Firefox starts)
  * Appearance:
    * Flat Underline (for making my tabs look cool: not been updated for a long time, requires checkCompatibility)


