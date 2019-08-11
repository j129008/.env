export PATH=$PATH:$HOME/.local/bin
export ZSH=$HOME/.oh-my-zsh
export SUDO_EDITOR='/usr/bin/vim'

plugins=(git zsh-autosuggestions autojump)
ZSH_THEME="candy"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export TERM=screen-256color

source $ZSH/oh-my-zsh.sh
