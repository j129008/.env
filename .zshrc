export PATH=$PATH:$HOME/.local/bin
export ZSH=$HOME/.oh-my-zsh

plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting tmux docker git-extras git-flow golang pyenv fzf)
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export TERM=screen-256color
export PYTHONIOENCODING=utf-8
export PATH=$PATH:/usr/local/go/bin
export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
export PATH=$PATH:$DOCKER_CONFIG

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# NVM lazy loading (faster shell startup)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}
node() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    node "$@"
}
npm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    npm "$@"
}

# Pyenv environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

export PATH="/Users/david/Downloads/sonar-scanner-6.2.1.4610-macosx-aarch64/bin/:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/david/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/david/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/david/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/david/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/Users/david/.bun/_bun" ] && source "/Users/david/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Task Master aliases added on 5/1/2025
alias tm='task-master'
alias taskmaster='task-master'

# BEGIN ServBay Environment Block
# ==============================================================
# ATTENTION: This section is automatically generated and managed
#            by the ServBay application to configure environment
#            variables for its services (PHP, Node, DBs, etc.).
#
# DO NOT EDIT THIS BLOCK MANUALLY - YOUR CHANGES WILL BE LOST
#            during Servbay updates or restarts.
#
# For support and documentation, please visit:
# https://support.servbay.com
#
# If you encounter issues, try restarting your terminal or run
# `source ~/.zshrc` (or `source ~/.bash_profile`).
# ==============================================================
#
export PATH="/Applications/ServBay/script/alias:/Applications/ServBay/bin:/Applications/ServBay/sbin:/Applications/ServBay/script:/Applications/ServBay/package/python/current/Python.framework/Versions/Current/bin:/Applications/ServBay/package/node/current/bin:/Applications/ServBay/package/go/current/bin:/Applications/ServBay/package/openjdk/current/bin:/Applications/ServBay/package/rust/current/bin:/Applications/ServBay/package/ruby/current/bin:/Applications/ServBay/package/dotnetsdk/current:/Applications/ServBay/package/dotnetsdk/current/tools:$HOME/.dotnet/tools/Applications/ServBay/package/mono/current:$PATH"
### PostgreSQL Environment added by ServBay
export PGHOST="/Applications/ServBay/tmp"
# END ServBay Environment Block

alias claude="/Users/david/.claude/local/claude"
export PATH="$HOME/.npm-global/bin:$PATH"

# Added by Antigravity
export PATH="/Users/david/.antigravity/antigravity/bin:$PATH"

# Load local secrets (not in repo)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
