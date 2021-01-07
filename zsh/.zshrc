# Load other dotfiles
for file in ~/.{aliases,exports,exports-private}; do
  [[ -r $file ]] && [[ -f $file ]] && source "$file"
done

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

eval "$(fnm env)"

# Load virtualenv wrapper
[[ -s $VIRTUALENVWRAPPER_SH ]] && source "$VIRTUALENVWRAPPER_SH"

# Start keychain to avoid being prompted for password more than once
if [[ -s $SSH_ASKPASS ]]; then
  eval $(keychain --eval --quiet id_rsa_walmartlabs id_rsa)
fi

# disable XON/XOFF flow control (stops ctrl-s from disabling a tty)
stty -ixon

