# vim: syntax=sh

# Rust binaries on path installed via rustup
source $HOME/.cargo/env

# Vim is the default editor
export EDITOR=vim

# Configs directory
export CONFIGS_HOME=$HOME/projects/configs

# Android home folder
export ANDROID_HOME=$HOME/Android/Sdk

# Local python installed binaries
export PATH=$PATH:$HOME/.local/bin

# Go bin folder
export PATH=$PATH:$HOME/go/bin

export PATH=$PATH:$HOME/apps/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$CONFIGS_HOME/bin:$CONFIGS_HOME/scripts

# Source a machine-specific profile
[[ -f ~/.profile.platform ]] && . ~/.profile.platform