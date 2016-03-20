#!/usr/bin/env sh
#
# Defaults for a fresh OSX installation
#

# Show ~/Library folder
chflags nohidden ~/Library

# Seil
# Map Caps Lock to right control
defaults write org.pqrs.Seil sysctl '{ "enable_capslock" = 1; "keycode_capslock" = 62; }'

# Karabiner
# Enable my private.xml mappings
# TODO

# Finder

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# iTerm 2
# TODO

