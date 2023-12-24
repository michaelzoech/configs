#!/usr/bin/env zsh

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

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

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

