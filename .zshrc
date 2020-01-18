export PATH=$PATH:$HOME/.local/bin
export ZSH=$HOME/.oh-my-zsh
export SUDO_EDITOR='/usr/bin/vim'

plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting django tmux docker git-extras git-flow go golang)
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
export TERM=screen-256color
export CLANG_LIBRARY='/usr/lib/llvm-3.8/lib'
export PYTHONIOENCODING=utf-8
export PATH=$PATH:/usr/local/go/bin

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
