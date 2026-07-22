# Exit if non-interactive
[[ ! $- == *i* ]] && return 0

BASH_PLUGINS=(
  base-settings
  utils
)
BASH_THEME="default"

source ~/.bash-plugins/bootstrap.bsh
