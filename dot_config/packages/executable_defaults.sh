#! /usr/bin/env bash

# Tweak defaults on macOS

# this article was extremely useful for figuring out defaults commands:
# https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
# essentially, you can use `defaults domains` and `defaults read` to figure out what you've changed

# important defaults cmds
# hide icons on the desktop:
defaults write com.apple.finder CreateDesktop true
defaults write org.macosforge.xquartz.X11 app_to_run /usr/local/bin/urxvt
defaults write org.macosforge.xquartz.X11 app_to_run /usr/bin/true
defaults write com.apple.dock no-bouncing -bool TRUE
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool NO

# immediately ask for PW after locking screen
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


# ---- ----

# trackpad

# Trackpad > Scroll & Zoom > Scroll direction: Natural
defaults write -g com.apple.swipescrolldirection -bool false

# Trackpad > More Gestures > Swipe between pages: swipe with three fingers
# this doesnt totally work?
# defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
# defaults write com.apple.AppleMultiTouchTrackpad TrackpadThreeFingerHorizSwipeGesture -bool True
# defaults write com.apple.AppleMultiTouchTrackpad TrackpadThreeFingerVertSwipeGesture -bool True

# ---- ----

# keyboard > shortcuts > app shortcuts

# chrome
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Select Next Tab" '$\U2192'
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Select Previous Tab" '$\U2190'

# firefox
defaults write org.mozilla.firefox NSUserKeyEquivalents -dict-add "History" '@y'

# outlook
defaults write com.microsoft.Outlook NSUserKeyEquivalents -dict-add Calendar '$\U2192'
defaults write com.microsoft.Outlook NSUserKeyEquivalents -dict-add Mail '$\U2190'
defaults write com.microsoft.Outlook NSUserKeyEquivalents -dict-add "Next Week" '\U2192'
defaults write com.microsoft.Outlook NSUserKeyEquivalents -dict-add "Previous Week" '\U2190'

# ---- ----
