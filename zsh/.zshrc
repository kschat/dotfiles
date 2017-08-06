# Load other dotfiles
for file in ~/.{aliases,exports}; do
  [[ -r $file ]] && [[ -f $file ]] && source "$file"
done

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load NVM into a shell session
[[ -s $NVM_DIR/nvm.sh ]] && source "$NVM_DIR/nvm.sh"

# Load virtualenv wrapper
[[ -s $VIRTUALENVWRAPPER_SH ]] && source "$VIRTUALENVWRAPPER_SH"

# Start keychain to avoid being prompted for password more than once
if [[ -s $SSH_ASKPASS ]]; then
  eval $(keychain --eval --quiet id_rsa_walmartlabs id_rsa)
fi

# disable XON/XOFF flow control (stops ctrl-s from disabling a tty)
stty -ixon

# Load RVM into a shell session *as a function*
[[ -s $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm"

