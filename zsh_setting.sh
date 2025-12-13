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
echo ">>> 複製設定檔..."
cp -v ./.zshrc ~/.zshrc
cp -v ./.p10k.zsh ~/.p10k.zsh
cp -v ./.vimrc ~/.vimrc
cp -v ./.vim_dict ~/.vim_dict
cp -v ./.gitconfig ~/.gitconfig
cp -v ./.tmux.conf ~/.tmux.conf
cp -v ./.tern-project ~/.tern-project

# install vim-plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo ">>> 安裝 vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo ">>> vim-plug 已安裝，跳過"
fi

echo ""
echo "=== 設定完成 ==="
echo "請執行以下指令完成安裝："
echo "  1. vim +PlugInstall +qall   # 安裝 Vim 插件"
echo "  2. exec zsh                 # 重新載入 shell"
