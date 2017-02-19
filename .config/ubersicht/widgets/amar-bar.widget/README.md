# zenbar

![Screenshot](screen-nocharge.png)
![Screenshot](screen-charge.png)

Übersicht system information bar for use with kwm window manager. My zenbar results from multiple successive forks:  
* [Herrbischoff's original nerdbar](https://github.com/herrbischoff/nerdbar.widget), inspired by koekeishiya's NerdTool configuration
* [koekeishiya's modified nerdbar](https://github.com/koekeishiya/nerdbar.widget) (kwm/khd author)  
  * added `active-space` widget
  * added support for font-awesome icons
  * improved querying to kwmc
  * fixed now playing: `playing.coffee`, which uses Firefox plugin [CurrentSong](https://addons.mozilla.org/en-us/firefox/addon/currentsong/) to also display the currently-playing song in the bar  
* [deathbeam's modified nerdbar](https://github.com/deathbeam/dotfiles/tree/master/lib/macos/bar.widget), which made the following additions:  
  * modifed `focused-window` to include current/total spaces (very helpful)
  * ellipsis cutoff if focused-window title is too long

And my changes:  
* Added bolt symbol near battery to indicate when charging (font-awesome currently (Jan 2017) has no charging battery symbol) - see screenshots
* Changed font to monospace and increased the size in certain areas for important text
* Modified widget spacing

## Installation

Make sure you have [Übersicht](http://tracesof.net/uebersicht/) installed, and then clone this repository.  

```bash
git clone https://github.com/Amar1729/zenbar $HOME/Library/Application\ Support/Übersicht/widgets/amar-zenbar.widget
```

Note, if you ever rename the directory, you have to change the image paths in `background.coffee` and `focused-window.coffee`, since they source css and scripts (respectively) starting with the parent directory's name.
