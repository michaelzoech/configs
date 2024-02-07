# vim: syntax=sh

function add_path() {
  export PATH="$PATH:$1"
}

function prepend_path() {
  export PATH="$1:$PATH"
}

export EDITOR=nvim
export CONFIGS_HOME="$HOME/p/configs"
export ANDROID_HOME="$HOME/Library/Android/sdk"

add_path "$HOME/go/bin"
add_path "$HOME/.mix/escripts"
add_path "$ANDROID_HOME/platform-tools"

eval "$(/opt/homebrew/bin/brew shellenv)"

