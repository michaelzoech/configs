# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal2"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:editor' keymap 'emacs'

source $ZSH/oh-my-zsh.sh

# Source common shell settings
. ~/.shrc

# Always show path in prompt
unsetopt auto_name_dirs

# Use jj to switch into command mode (Esc replacement)
bindkey "jj" vi-cmd-mode

# Use https://github.com/ndbroadbent/scm_breeze for better git aliases
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && . "$HOME/.scm_breeze/scm_breeze.sh"

# Use autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

export PATH=$HOME/.rbenv/shims:$PATH

source $HOME/.cargo/env

case `uname -s` in
    Darwin)
        RUST_TOOLCHAIN_NAME=stable-x86_64-apple-darwin
        ;;
    *)
        RUST_TOOLCHAIN_NAME=stable-x86_64-unknown-linux-gnu
        ;;
esac

RUST_SRC_PATH=$HOME/.multirust/toolchains/$RUST_TOOLCHAIN_NAME/lib/rustlib/src/rust/src

export PATH=$PATH:$HOME/apps:$HOME/.local/bin

source $HOME/.zshrc.platform

# Disable shell flow control (usage of C-s and C-q as shell shortcuts)
# C-s would enable terminal scroll lock
# C-q would disable scroll lock
# This way I can use these shortcuts in e.g. vim
stty -ixon

