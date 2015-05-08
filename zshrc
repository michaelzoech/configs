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

# Misc aliases
alias a='arun'
alias f="find . -iname"
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

# do an ls after every successful cd
function cd {
	builtin cd "$@" && ls
}

# Always show path in prompt
unsetopt auto_name_dirs

export EDITOR=vim

# Use jj to switch into command mode (Esc replacement)
bindkey "jj" vi-cmd-mode

# Use RVM to manage Ruby versions
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin

# Use https://github.com/ndbroadbent/scm_breeze for better git aliases
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && . "$HOME/.scm_breeze/scm_breeze.sh"

source $HOME/.zshrc.`uname -s`

