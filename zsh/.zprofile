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

export PATH="$HOME/.cargo/bin:$PATH"
