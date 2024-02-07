#vim: syntax=sh

# Source common shell settings
source "$HOME/.shrc"

# Use uu to switch into command mode (Esc replacement)
bindkey "uu" vi-cmd-mode

autoload -Uz compinit
compinit

# https://github.com/scmbreeze/scm_breeze for better git aliases
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

[[ -f "$HOME/.zshrc.platform" ]] && source "$HOME/.zshrc.platform"

# Just no
setopt NOBEEP

export HISTSIZE=50000
export SAVEHIST=45000
# man zshoptions
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_expire_dups_first

# fzf
source "/opt/homebrew/opt/fzf/shell/completion.zsh"
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

PS1='%F{green}%n@%m %~%f
%(?.%F{green}.%F{red})»%f '

