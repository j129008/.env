# ====================
# Machine-local pre-init (not in repo)
# ====================
# fpath additions for completions must land before oh-my-zsh runs compinit,
# otherwise each installer appends its own compinit call and startup pays for
# every one of them.
[ -f ~/.zshrc.local.pre ] && source ~/.zshrc.local.pre

# ====================
# Oh-My-Zsh Configuration
# ====================
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
DISABLE_UPDATE_PROMPT=true

# the pyenv and fzf plugins run their own init; ~/.zprofile already exports
# PYENV_ROOT and runs `pyenv init --path`, so nothing here repeats it
plugins=(git zsh-autosuggestions zsh-syntax-highlighting pyenv fzf)

source $ZSH/oh-my-zsh.sh

# ====================
# Environment Variables
# ====================
# TERM is deliberately left alone: the terminal emulator sets it, and tmux sets
# tmux-256color inside panes. Hardcoding it here overrode that and cost us
# 24-bit colour and italics both inside and outside tmux.
export PYTHONIOENCODING=utf-8
export EDITOR=vim
export VISUAL=vim

# ====================
# PATH Configuration
# ====================
typeset -U path PATH  # drop duplicates instead of growing on every re-source
# ~/Library/Python/3.13/bin is deliberately absent: it holds `pip install --user`
# binaries from the macOS system python and sat ahead of the pyenv shims, so a
# stale ruff/mypy shadowed the pyenv-managed one.
path=(
  $HOME/.local/bin
  $path
)

# ====================
# History
# ====================
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS  # keep only the most recent copy of a command
setopt HIST_IGNORE_SPACE     # a leading space keeps a command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY           # expand !! into the buffer instead of running it
setopt SHARE_HISTORY         # pick up commands typed in other panes

# ====================
# Powerlevel10k
# ====================
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ====================
# fzf
# ====================
# the oh-my-zsh fzf plugin wires up the keybindings and completion already,
# so this only tunes behaviour. ripgrep respects .gitignore and skips .git.
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# ====================
# Local settings and secrets (not in repo)
# ====================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
