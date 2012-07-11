# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="minimal"

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
zstyle ':omz:editor' keymap 'vi'

source $ZSH/oh-my-zsh.sh

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
alias ti='tig --all'
alias gg='arun gitg --all'

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

# Autojump faster directory switching
source ~/.autojump/etc/profile.d/autojump.zsh

# ant
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
ant () { command ant -logger org.apache.tools.ant.listener.AnsiColorLogger "$@" | sed 's/2;//g' ; }

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Use https://github.com/ndbroadbent/scm_breeze for better git aliases
[ -s "/home/maik/.scm_breeze/scm_breeze.sh" ] && . "/home/maik/.scm_breeze/scm_breeze.sh"

# Use RVM to manage Ruby versions
[[ -s "/home/maik/.rvm/scripts/rvm" ]] && source "/home/maik/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin

eval "$(fasd --init zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"
alias ff='fasd -f'
alias fd='fasd -d'
alias fa='fasd -a'
alias fs='fasd -si'
alias fsd='fasd -sid'
alias fsf='fasd -sif'
fasd_cd() { cd "$(fasd -e echo "$@")" } # use cd function
alias z='fasd_cd -d'
alias v='ff -e vim'
alias sv='ff -e "sudo vim"'
