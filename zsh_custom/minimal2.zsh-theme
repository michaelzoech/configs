ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo -n "- $ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

last_err_code() {
  if [[ $1 == 0 ]]; then
    echo -n " »"
  else
    echo -n " %{$bg[red]%}»%{$reset_color%}"
  fi
}

my_changes() {
  local PREV_CODE=$?
  git_custom_status
  last_err_code $PREV_CODE
}

PROMPT='%3~ $(my_changes) %b'
