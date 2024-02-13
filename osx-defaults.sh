#!/usr/bin/env zsh
#
# https://macos-defaults.com/
#

# Show ~/Library folder
chflags nohidden ~/Library

# Change screenshot default from png to jpg
defaults write com.apple.screencapture type jpg

## For all input sources

# No automatic capitalization
defaults write -g NSAutomaticCapitalizationEnabled -bool false
# No period with double-spaces
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
# No automatic spell correction
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
# TODO
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Finder

# Show all filename extensions
defaults write -g AppleShowAllExtensions -bool true
# Show path bar in the bottom
defaults write com.apple.finder ShowPathbar -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# Hide all icons on desktop
defaults write com.apple.finder CreateDesktop -bool false

killall Finder

# Space for Menubar icons

#defaults write -g NSStatusItemSelectionPadding -int 6
#defaults write -g NSStatusItemSpacing -int 8

## Dock

# Dock on the left
defaults write com.apple.dock orientation -string left
# Faster minimize effect
defaults write com.apple.dock mineffect -string scale
# Instant dock toggle
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
# Make hidden apps transparent in dock
defaults write com.apple.dock showhidden -bool true
# Show Cmd+Tab switcher on all displays
defaults write com.apple.dock appswitcher-all-displays -bool true

killall Dock

