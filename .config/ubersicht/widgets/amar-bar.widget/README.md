# zenbar

![Screenshot](screent.png)

Übersicht system information bar for use with kwm window manager. My zenbar results from multiple successive forks:  
* [Herrbischoff's original nerdbar](https://github.com/herrbischoff/nerdbar.widget)
* [deathbeam's modified nerdbar](https://github.com/deathbeam/dotfiles/tree/master/lib/macos/bar.widget), which made the following additions:  
  * modifed `focused-window` to include current/total spaces (very helpful)
  * ellipsis cutoff if focused-window title is too long
  * added icons for focused-window, mem/cpu, date, and time
  * `playing.coffee`, which uses Firefox plugin [CurrentSong](https://addons.mozilla.org/en-us/firefox/addon/currentsong/) to also display the currently-playing song in the bar

And my changes:  
* Added bolt symbol near battery to indicate AC Power (font-awesome currently (Jan 2017) has no charging battery symbol)
* Changed font to monospace and increased the size in certain areas for important text
* Modified widget spacing

## Installation

Make sure you have [Übersicht](http://tracesof.net/uebersicht/) installed.

Then clone this repository.

```bash
git clone https://github.com/Amar1729/zenbar $HOME/Library/Application\ Support/Übersicht/widgets/amar-zenbar.widget
```
