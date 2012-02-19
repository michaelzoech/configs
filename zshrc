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

