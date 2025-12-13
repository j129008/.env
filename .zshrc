# ====================
# Oh-My-Zsh Configuration
# ====================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
plugins=(git zsh-autosuggestions zsh-syntax-highlighting pyenv fzf)

source $ZSH/oh-my-zsh.sh

# ====================
# Environment Variables
# ====================
export TERM=screen-256color
export PYTHONIOENCODING=utf-8

# ====================
# PATH Configuration
# ====================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.13/bin:$PATH"

# ====================
# Pyenv (Python version management)
# ====================
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# ====================
# Powerlevel10k
# ====================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ====================
# fzf
# ====================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ====================
# ServBay
# ====================
# BEGIN ServBay Environment Block
export PATH="/Applications/ServBay/script/alias:/Applications/ServBay/bin:/Applications/ServBay/sbin:/Applications/ServBay/script:/Applications/ServBay/package/python/current/Python.framework/Versions/Current/bin:$PATH"
export PGHOST="/Applications/ServBay/tmp"
# END ServBay Environment Block

# ====================
# Aliases
# ====================
alias claude="$HOME/.claude/local/claude"

# ====================
# Local Secrets (not in repo)
# ====================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
