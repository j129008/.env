# ====================
# Login shell setup
# ====================
# .zprofile runs before .zshrc and, unlike .zshrc, also applies to
# non-interactive shells. Anything a script or an editor subprocess needs on
# PATH belongs here rather than in .zshrc.

# ====================
# Homebrew
# ====================
# Apple Silicon first, then Intel
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$_brew" ]; then
        eval "$("$_brew" shellenv)"
        break
    fi
done
unset _brew

# ====================
# Pyenv (Python version management)
# ====================
# only `init --path` here: it puts the shims on PATH, which is what scripts
# need. The interactive half (`pyenv init -`) is handled by the oh-my-zsh
# pyenv plugin in .zshrc -- don't duplicate it.
export PYENV_ROOT="$HOME/.pyenv"
# git-clone installs put the binary in $PYENV_ROOT/bin; the Homebrew one is
# already on PATH from shellenv above and leaves $PYENV_ROOT as a data dir
[ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init --path)"
fi

# ====================
# Machine-local login settings (not in repo)
# ====================
[ -f ~/.zprofile.local ] && source ~/.zprofile.local
