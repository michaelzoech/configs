# vim: syntax=sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source common shell settings
. ~/.shrc

# Usage .. [n]
# Go up n-levels.
function .. (){
  local arg=${1:-1};
  local dir=""
  while [ $arg -gt 0 ]; do
    dir="../$dir"
    arg=$(($arg - 1));
  done
  cd $dir #>&/dev/null
}

# Usage ... Thing/Some
# Go up until you encounter Thing/Some, then go there
function ... (){
  if [ -z "$1" ]; then
    return
  fi
  local maxlvl=16
  local dir=$1
  while [ $maxlvl -gt 0 ]; do
      dir="../$dir"
      maxlvl=$(($maxlvl - 1));
      if [ -d "$dir" ]; then
        cd "$dir" #>&/dev/null
		return
      fi
  done
}

function _pathelem(){
	local IFS=$'\n'
	if [ "$1" != "$3" ]; then # there already is an argument
		return
	fi
	# sed1: remove current folder
	# sed2: add backslashes to escape whitespaces
	# sed3: split the path
  local pardirs=$(pwd | sed -r s/"\/[^\/]+$"// | sed s/" "/'\\\\ '/g | sed s/"\/"/"\n"/g)
	cur=$(echo ${COMP_WORDS[COMP_CWORD]} | sed s/"\\\\"/"\\\\\\\\\\\\"/)
	# 12! backslashes, srsly?
  COMPREPLY=($(compgen -W "$pardirs" -- $cur))
}

complete -F _pathelem ...

#alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
