# vim: syntax=sh

# Vim is the default editor
export EDITOR=vim

# Source a machine-specific profile
[[ -f ~/.profile.platform ]] && . ~/.profile.platform
