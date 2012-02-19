# Sets Oh My Zsh options.

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:terminal' auto-title 'yes'

# Set the plugins to load (see $OMZ/plugins/).
#zstyle ':omz:load' plugin 'archive' 'git'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:prompt' theme 'minimal'

# Define LANG used in environment.sh sourced by init.sh
export LANG="en_US.UTF-8"

# This will make you shout: OH MY ZSHELL!
source "$HOME/.oh-my-zsh/init.zsh"

# Misc aliases
alias a='arun'
alias f="find . -iname"
alias ls='ls --color=auto'
alias u='ls'
alias i='ls -lh'
alias m="make"
alias m2="make -j2"
alias m4="make -j4"
alias m8="make -j8"
alias mk="mkdir -p"
alias qg='arun qgit --all'

# yaourt
alias y='yaourt'
alias yr='yaourt -R'
alias yrs='yaourt -Rs'
alias ys='yaourt -S'
alias yss='yaourt -Ss'
alias yu='yaourt -Syu'

# Subversion
alias sa='svn add'
alias scm='svn commit -m'
alias sd='svn diff'
alias st='svn diff --diff-cmd meld'
alias sll='svn log --limit'
alias spe='svn propedit svn:externals .'
alias spi='svn propedit svn:ignore .'
alias ss='svn status'
alias sup='svn update'

# Android
alias ain='adb install'
alias aun='adb uninstall'

# recursive mkdir and cd if successful
function mkcd {
	mkdir -p "$@" && builtin cd "$@"
}

# Always show path in prompt
unsetopt auto_name_dirs

export EDITOR=vim

# Enable ccache for Android NDK and AOSP projects
export USE_CCACHE=1
export NDK_CCACHE=ccache

export ANDROID_HOME=/opt/android-sdk
export ANDROID_NDK=/opt/android-ndk
export CONFIGS_HOME=$HOME/projects/configs/work

export PATH=$PATH:$HOME/apps/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_NDK:$CONFIGS_HOME/scripts

# Use https://github.com/ndbroadbent/scm_breeze for better git aliases
[ -s "/home/maik/.scm_breeze/scm_breeze.sh" ] && . "/home/maik/.scm_breeze/scm_breeze.sh"

# Use RVM to manage Ruby versions
[[ -s "/home/maik/.rvm/scripts/rvm" ]] && source "/home/maik/.rvm/scripts/rvm"

# Show vi mode at right side
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Use jj to switch into command mode (Esc replacement)
bindkey "jj" vi-cmd-mode
