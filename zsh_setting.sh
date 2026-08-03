#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== 開始設定開發環境 ==="

# install oh-my-zsh (RUNZSH=no 防止自動切換 shell)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo ">>> 安裝 oh-my-zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo ">>> oh-my-zsh 已安裝，跳過"
fi

# install zsh-autosuggestions
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo ">>> 安裝 zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo ">>> zsh-autosuggestions 已安裝，跳過"
fi

# install zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo ">>> 安裝 zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo ">>> zsh-syntax-highlighting 已安裝，跳過"
fi

# install zsh theme powerlevel10k
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo ">>> 安裝 powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo ">>> powerlevel10k 已安裝，跳過"
fi

# copy dotfiles
# 覆蓋前先備份：家目錄的檔案可能被安裝程式（Docker、IDE 等）追加過內容，
# 直接 cp 會靜靜地把那些改動刪掉
echo ">>> 複製設定檔..."
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
for f in .zshrc .p10k.zsh .vimrc .gitconfig .tmux.conf; do
    if [ -f "$HOME/$f" ] && ! cmp -s "./$f" "$HOME/$f"; then
        mkdir -p "$BACKUP_DIR"
        cp -p "$HOME/$f" "$BACKUP_DIR/$f"
        echo "    備份 $f -> $BACKUP_DIR/$f"
    fi
    cp -v "./$f" "$HOME/$f"
done
[ -d "$BACKUP_DIR" ] && echo ">>> 舊設定已備份到 $BACKUP_DIR"

# 機器專屬設定不進 repo，放在這兩個檔案（zsh_setting.sh 不會動它們）：
#   ~/.zshrc.local.pre  — 需要在 oh-my-zsh 之前執行的 fpath / PATH
#   ~/.zshrc.local      — 其餘設定與 API key

# install vim-plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo ">>> 安裝 vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo ">>> vim-plug 已安裝，跳過"
fi

# install fzf
if [ ! -d "$HOME/.fzf" ]; then
    echo ">>> 安裝 fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all --no-bash --no-fish
else
    echo ">>> fzf 已安裝，跳過"
fi

# install ripgrep
if ! command -v rg &> /dev/null; then
    echo ">>> 安裝 ripgrep..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install ripgrep
    else
        sudo apt-get install -y ripgrep
    fi
else
    echo ">>> ripgrep 已安裝，跳過"
fi

# install uv (modern Python package manager)
if ! command -v uv &> /dev/null; then
    echo ">>> 安裝 uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
else
    echo ">>> uv 已安裝，跳過"
fi

# install Python dev tools
echo ">>> 安裝 Python 開發工具..."
pip3 install --user --quiet jedi ruff mypy 2>/dev/null
echo ">>> jedi, ruff, mypy 已安裝"

echo ""
echo "=== 設定完成 ==="
echo "請執行以下指令完成安裝："
echo "  1. vim +PlugInstall +qall   # 安裝 Vim 插件"
echo "  2. exec zsh                 # 重新載入 shell"
echo ""
echo "Python 套件管理使用 uv："
echo "  uv pip install <package>   # 安裝套件"
echo "  uv venv                    # 建立虛擬環境"
echo "  uv run python script.py   # 執行腳本"
