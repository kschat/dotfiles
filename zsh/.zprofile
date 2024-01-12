#
# Executes commands at login pre-zshrc.
#

#
# Environment Variables
#

[[ -s "$HOME/.exports" ]] && source "$HOME/.exports"

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"

# Only run on Apple Silicon
if [[ $OSTYPE == darwin* && $(sysctl -n machdep.cpu.brand_string) =~ 'Apple' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
