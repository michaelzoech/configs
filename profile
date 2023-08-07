# vim: syntax=sh

# Rust binaries on path installed via rustup
source $HOME/.cargo/env

# Neovim is the default editor
export EDITOR=nvim

# Configs directory
export CONFIGS_HOME=$HOME/projects/configs

# Android
export ANDROID_HOME=$HOME/apps/Android/Sdk
export ANDROID_NDK_HOME=$HOME/apps/Android/Sdk/ndk-bundle

# Local python installed binaries
export PATH=$PATH:$HOME/.local/bin

# Go bin folder
export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/apps/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$CONFIGS_HOME/bin:$CONFIGS_HOME/scripts

# Source a machine-specific profile
[[ -f ~/.profile.platform ]] && . ~/.profile.platform
