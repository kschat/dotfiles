if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load other dotfiles
for file in ~/.{aliases,exports}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

source "$(brew --prefix nvm)/nvm.sh"

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

archey
