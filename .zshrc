export PATH=$PATH:$HOME/.local/bin
export ZSH=$HOME/.oh-my-zsh

plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting tmux docker git-extras git-flow golang pyenv fzf)
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export TERM=screen-256color
export CLANG_LIBRARY='/usr/lib/llvm-3.8/lib'
export PYTHONIOENCODING=utf-8
export PATH=$PATH:/usr/local/go/bin
export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
export PATH=$PATH:DOCKER_CONFIG

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Pyenv environment variables
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
