#!/usr/bin/env zsh

# ask for sudo permissions upfront
sudo -v

# keep permissions for the duration of the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
# configuration variables
#

dependencies=(
  stow
  git
  zsh
  tmux
  vim
)

arch_dependencies=(
  terminator
  gnome-shell-themes-elegance-colors
  sublime-text-dev
)

osx_dependencies=(
  brew
  caskroom/cask/brew-cask
)

debian_dependencies=()

git_dependencies=(
  '--recursive https://github.com/sorin-ionescu/prezto.git ./temp-dir/.zprezto'
  'https://github.com/gmarik/Vundle.vim.git ./temp-dir/.vim/bundle/Vundle.vim'
)

typeset -A packages

packages=(
  git "$HOME"
  vim "$HOME"
  terminator "$HOME"
)

#
# variable declarations
#

platform=''
package_manager=''
package_manager_arguments=''

log_level=2
force=false

# color codes
colors=(
  "$(tput setaf 1)" # error
  "$(tput setaf 7)" # normal
  "$(tput setaf 6)" # info
  "$(tput setaf 3)" # warn
  "$(tput sgr0)"    # reset
)

#
# function declarations
#

function log {
  local log_string="${colors[$1]}${2}${reset_color}"

  # test if we should log
  if [[ "$1" -gt "$log_level" ]]; then
    return 0
  fi

  # redirect to stderr if we're logging an error
  if [[ "$1" -eq 1 ]]; then
    echo "$log_string" >&2
  else
    echo "$log_string"
  fi
}

function fatal_error {
  local status_code="${1:-1}"
  local msg="${2:-Fatal error occured}"

  log 1 $msg
  exit status_code
}

function install_package_manager {
  case "$1" in
    osx)  ;;
    arch) ;;
    *)    return 1;;
  esac
}

function construct_dependency_arguments {
  case "$1" in
    yaourt)   echo "--noconfirm -S $dependencies $arch_dependencies";;
    brew)     echo "install $dependencies $osx_dependencies";;
    apt-get)  echo "install $dependencies $debian_dependencies";;
    *)        return 1;;
  esac
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
    -v|--verbose)
      log_level=3
      shift
      ;;
    -vv)
      log_level=4
      shift
      ;;
    -vvv)
      log_level=4
      set -x
      shift
      ;;
    *)
      exit 0
      ;;
  esac
done

#
# detect platform and package manager
#

log 3 'Detecting platform'

case "$(uname -rv | tr '[:upper:]' '[:lower:]')" in
  *arch*) platform='arch';;
  *darwin*) platform='osx';;
  *debian*|*ubuntu*) platform='debian';;
  *) platform='unknown';;
esac

log 3 "Platform: [$platform]"
log 3 'Detecting package manager'

if hash yaourt 2> /dev/null; then
  package_manager='yaourt'
elif hash brew 2> /dev/null; then
  package_manager='brew'
elif hash apt-get 2> /dev/null; then
  package_manager='apt-get'
else
  package_manager='unknown'
fi

log 3 "Package manager: [$package_manager]"

if [[ "$platform" == 'unknown' && "$package_manager" == 'unknown' ]]; then
  fatal_error 1 'Unsupported system'
fi

#
# install missing package managers
#

if [[ "$package_manager" == 'unknown' ]] && ! install_package_manager "$platform"; then
  fatal_error 2 'Failed installing package manager'
fi

package_manager_arguments="$(construct_dependency_arguments "$package_manager")"

echo "$package_manager_arguments" | xargs "$package_manager"

# prompt user if installs failed
if [[ "$?" -ne 0 ]]; then
  read -q $'continue?No dependencies installed. Continue? [y/N]\n' || exit 3
fi

#
# install dependencies with git
#

if hash git 2> /dev/null; then
  mkdir -p ~/.vim/bundle

  for dep in $git_dependencies; do
    echo "$dep" | xargs git clone
  done
fi

#
# symlink packages from this repo
#

for package in "${(@k)packages}"; do
  stow -t "${packages[$package]:-"$HOME"}" "$package"
done
