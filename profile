# vim: syntax=sh

# TODO should not be needed as /etc/profile is sourced automatically
# Load profiles from /etc/profile.d
#if test -d /etc/profile.d/; then
#   for profile in /etc/profile.d/*.sh; do
#       test -r "$profile" && . "$profile"
#   done
#   unset profile
#fi

# TODO ls with color output, verify this on Linux instead of alias for ls
#export CLICOLOR=cons25

# Vim is the default editor
export EDITOR=vim

[[ -f ~/.profile.machine ]] && . ~/.profile.machine
