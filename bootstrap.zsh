#!/usr/bin/env zsh

#
# variable declarations
#

force=false
logging_on=false
debug=false

# color codes
info_color=$(tput setaf 6)
error_color=$(tput setaf 1)
reset_color=$(tput sgr0)

# global deps: stow, git, prezto, zsh, tmux, vim, sublime
# arch: terminator, elegance-colors
# os x: brew

dependencies=(
  stow
  git
  zsh
  tmux
  vim
)

arch_dependencies=(
  terminator
  elegance-colors
)

osx_dependencies=(
  brew
  caskroom/cask/brew-cask
)

#
# function declarations
#

function log {
  logging_on && echo "${1}${2}${reset_color}"
}

#
# parse command arguments
#

while test $# -gt 0; do
  case "$1" in
    -f|--force)
      force=true
      shift
      ;;
    --debug)
      debug=true
      shift
      ;;
    -v|--verbose)
      logging_on=true
      shift
    *)
      exit 0
      ;;
  esac
done

#
# detect package manager
#

# Arch
if hash pacman 2> /dev/null; then

  pacman -S "$dependencies"

# OS X
elif hash brew 2> /dev/null; then

  brew install "$dependencies"

# Debian
elif hash apt-get 2> /dev/null; then

  apt-get install "$dependencies"

# unknown
else

  echo 'No supported package manager found'
  exit 1

fi

# prompt user if installs failed
if [[ "$?" -gt 0 ]]; then

fi
