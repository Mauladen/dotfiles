export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

plugins=(git zsh-autocomplete zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"