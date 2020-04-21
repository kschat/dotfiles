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

if [[ "$OSTYPE" == darwin* ]]; then
  # Increase open file limit to something not terrible on OS X
  ulimit -n 65536 65536
fi


export PATH="$HOME/.cargo/bin:$PATH"
