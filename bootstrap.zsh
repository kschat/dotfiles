#!/usr/bin/env zsh

# ask for sudo permissions upfront
sudo -v

# keep permissions for the duration of the script
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#
# variable declarations
#

platform=''
package_manager=''
package_manager_arguments=''

log_level=1
force=false
default_directory="./temp-dir"

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
  caskroom/cask/brew-cask
)

debian_dependencies=()

git_dependencies=(
  "--recursive https://github.com/sorin-ionescu/prezto.git $default_directory/.zprezto"
  "https://github.com/gmarik/Vundle.vim.git $default_directory/.vim/bundle/Vundle.vim"
)

# dotfiles to symlink
# utility_name -> target_directory
typeset -A packages; packages=(
  zsh "$default_directory"
  git "$default_directory"
  vim "$default_directory"
  terminator "$default_directory"
  tf2 "$default_directory/.steam/steam/steamapps/common/Team Fortress 2/tf/custom"
)

#
# color codes
#

reset_color="$(tput sgr0)"
bold="$(tput bold)"

typeset -A log_colors; log_colors=(
  error   "$(tput setaf 1)"
  normal  "${bold}$(tput setaf 7)"
  warn    "$(tput setaf 3)"
  info    "$(tput setaf 6)"
)

#
# function declarations
#

function prompt {
  local message="$1"
  # Split second argument by '/' and remove square brackets
  local -a options; options=("${(@s|/|)2//[\[\]]/}")
  local options_length="$(( $#options + 1 ))"
  local export_variable="$3"
  local default=''
  local response=''
  local response_index=1

  # extract the default value by finding the first uppercase option
  for index in {1..$#options}; do
    local option="${options[$index]}"

    [[ "$option" =~ '[A-Z]' ]] && default="${option:l}"

    options[$index]="${option:l}"
  done

  unset option

  vared -p "$message $2 " response

  # get the first character and lowercase it
  response="${response:0:1:l}"

  # check if the response is one of the provided options
  response_index="${options[(i)$response]}"

  # set to default if response isn't found in options
  [[ "$response_index" -eq "$options_length" ]] && response="$default"

  # export the response if an export variable was provided
  if [[ -n "$export_variable" ]]; then
    typeset -g "$3"="$response"
    return 0
  fi

  echo $response
}

function log {
  local -a levels; levels=("${(@k)log_colors}")
  local log_string="${log_colors[$1]}${2}${reset_color}"

  # test if we should log
  if [[ "$1" != 'normal' && "${levels[(i)$1]}" -gt "$log_level" ]]; then
    return 0
  fi

  # redirect to stderr if we're logging an error
  if [[ "$1" == 'error' ]]; then
    echo $log_string >&2
  else
    echo $log_string
  fi
}

function fatal_error {
  local status_code="${1:-1}"
  local msg="${2:-Fatal error occured}"

  log error "$msg"
  exit status_code
}

function install_package_manager {
  case "$1" in
    osx)  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";;
    arch) ;;
    *)    false;;
  esac

  echo $?
}

function construct_dependency_arguments {
  case "$1" in
    yaourt)   echo --noconfirm -S $dependencies $arch_dependencies;;
    brew)     echo install $dependencies $osx_dependencies;;
    apt-get)  echo install $dependencies $debian_dependencies;;
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

log info 'Detecting platform'

case "$(uname -rv | tr '[:upper:]' '[:lower:]')" in
  *arch*) platform='arch';;
  *darwin*) platform='osx';;
  *debian*|*ubuntu*) platform='debian';;
  *) platform='unknown';;
esac

log info "Platform: [$platform]"
log info 'Detecting package manager'

if hash yaourt 2> /dev/null; then
  package_manager='yaourt'
elif hash brew 2> /dev/null; then
  package_manager='brew'
elif hash apt-get 2> /dev/null; then
  package_manager='apt-get'
else
  package_manager='unknown'
fi

log info "Package manager: [$package_manager]"

if [[ "$platform" == 'unknown' && "$package_manager" == 'unknown' ]]; then
  fatal_error 1 'Unsupported system'
fi

#
# install missing package managers
#

if [[ "$package_manager" == 'unknown' ]] && ! install_package_manager "$platform"; then
  fatal_error 2 'Failed installing package manager'
fi

#
# install dependencies with package manager
#

prompt "Install dependencies with $package_manager?" '[y/N]' install_dependencies

if [[ "$install_dependencies" == 'y' ]]; then
  package_manager_arguments="$(construct_dependency_arguments "$package_manager")"

  echo $package_manager_arguments | xargs "$package_manager"

  # prompt user if install failed
  if [[ "$?" -ne 0 ]]; then
    prompt "$(log warn 'An error occured while install dependencies. Continue?')" '[y/N]' continue_install

    [[ "$continue_install" == 'n' ]] && exit 4
  fi
fi

#
# install dependencies with git
#

prompt "Install dependencies with git?" '[y/N]' install_git_dependencies

if [[ "$install_git_dependencies" == 'y' ]]; then
  if hash git 2> /dev/null; then
    for dep in $git_dependencies; do
      echo "$dep" | xargs git clone
    done
  fi

  # prompt user if install failed
  if [[ "$?" -ne 0 ]]; then
    prompt "$(log warn 'An error occured while installing with git. Continue?')" '[y/N]' continue_install

    [[ "$continue_install" == 'n' ]] && exit 5
  fi
fi

#
# symlink packages from this repo
#

prompt 'Symlink dotfiles?' '[y/N]' symlink_dotfiles

if [[ "$symlink_dotfiles" == 'y' ]];then
  mkdir -p "$default_directory"

  for package in "${(@k)packages}"; do
    local destination_dir="${packages[$package]:-"$default_directory"}"

    mkdir -p "$destination_dir" && stow -t "$destination_dir" "$package"
  done

  # prompt user if install failed
  if [[ "$?" -ne 0 ]]; then
    log warn $'An error occured while symlinking files.\n'
    exit 6
  fi

  # if we're on OS X, use keychain for credentials instead
  [[ "$platform" == "osx" ]] && git config --global credential.helper 'osxkeychain'
fi

