#!/bin/bash
#
# CLI 開發環境設定管理
#
#   ./setup.sh            # 等同 install
#   ./setup.sh install    # 安裝缺少的工具，並把設定檔連結到家目錄
#   ./setup.sh update     # git pull 後重新套用設定
#   ./setup.sh link       # 只重建 symlink，不安裝任何東西
#   ./setup.sh status     # 檢查現況，不做任何修改
#   ./setup.sh help
#
# 設定檔是用 symlink 連到家目錄，不是複製。改完 repo 裡的檔案立刻生效，
# 也不會再發生家目錄和 repo 內容分岔的問題。

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# 要連到家目錄的設定檔
DOTFILES=".zshrc .zprofile .p10k.zsh .vimrc .gitconfig .tmux.conf"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
BACKUP_ROOT="$HOME/.dotfiles-backup"

# ====================
# 輸出
# ====================
if [ -t 1 ]; then
    C_OK=$'\033[32m'; C_WARN=$'\033[33m'; C_ERR=$'\033[31m'
    C_DIM=$'\033[2m'; C_BOLD=$'\033[1m'; C_OFF=$'\033[0m'
else
    C_OK=''; C_WARN=''; C_ERR=''; C_DIM=''; C_BOLD=''; C_OFF=''
fi

say()   { printf '%s\n' "$*"; }
head_() { printf '\n%s==> %s%s\n' "$C_BOLD" "$*" "$C_OFF"; }
ok()    { printf '  %s✓%s %s\n' "$C_OK" "$C_OFF" "$*"; }
skip()  { printf '  %s·%s %s\n' "$C_DIM" "$C_OFF" "$*"; }
warn()  { printf '  %s!%s %s\n' "$C_WARN" "$C_OFF" "$*"; }

# ====================
# symlink 設定檔
# ====================
# 家目錄已經有的檔案：如果是別的內容就先備份，再換成 symlink。
# 安裝程式（Docker、IDE 等）常常直接追加內容到 ~/.zshrc，備份是保險。
link_dotfiles() {
    head_ "連結設定檔到家目錄"
    local backup_dir="" f src dst
    for f in $DOTFILES; do
        src="$SCRIPT_DIR/$f"
        dst="$HOME/$f"

        if [ ! -e "$src" ]; then
            warn "$f 不在 repo 裡，跳過"
            continue
        fi

        # 已經連對了就不用動
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            skip "$f 已連結"
            continue
        fi

        # 真實檔案或連錯的 symlink：先備份再換掉
        if [ -e "$dst" ] || [ -L "$dst" ]; then
            if [ -z "$backup_dir" ]; then
                backup_dir="$BACKUP_ROOT/$(date +%Y%m%d-%H%M%S)"
                mkdir -p "$backup_dir"
            fi
            cp -aL "$dst" "$backup_dir/$f" 2>/dev/null || cp -a "$dst" "$backup_dir/$f"
            rm -f "$dst"
            ln -s "$src" "$dst"
            ok "$f 已連結 ${C_DIM}(舊檔備份到 $backup_dir/$f)${C_OFF}"
        else
            ln -s "$src" "$dst"
            ok "$f 已連結"
        fi
    done
    if [ -n "$backup_dir" ]; then
        say ""
        say "  舊設定備份在 $backup_dir"
    fi
}

# ====================
# 安裝：oh-my-zsh 與外掛
# ====================
clone_if_missing() {
    local dir="$1" url="$2" name="$3"
    shift 3
    if [ ! -d "$dir" ]; then
        git clone "$@" "$url" "$dir" >/dev/null 2>&1
        ok "$name 已安裝"
    else
        skip "$name 已安裝"
    fi
}

install_omz() {
    head_ "oh-my-zsh 與外掛"

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        ok "oh-my-zsh 已安裝"
    else
        skip "oh-my-zsh 已安裝"
    fi

    clone_if_missing "$ZSH_CUSTOM/plugins/zsh-autosuggestions" \
        https://github.com/zsh-users/zsh-autosuggestions "zsh-autosuggestions"
    clone_if_missing "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" \
        https://github.com/zsh-users/zsh-syntax-highlighting.git "zsh-syntax-highlighting"
    clone_if_missing "$ZSH_CUSTOM/themes/powerlevel10k" \
        https://github.com/romkatv/powerlevel10k.git "powerlevel10k" --depth=1
}

# ====================
# 安裝：vim / fzf / CLI 工具
# ====================
install_pkg() {
    local cmd="$1" pkg="$2"
    if command -v "$cmd" >/dev/null 2>&1; then
        skip "$pkg 已安裝"
        return 0
    fi
    if [ "$pkg" = "uv" ]; then
        curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null 2>&1
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install "$pkg" >/dev/null 2>&1
    else
        sudo apt-get install -y "$pkg" >/dev/null 2>&1
    fi
    ok "$pkg 已安裝"
}

install_tools() {
    head_ "Vim 與 CLI 工具"

    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
        curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1
        ok "vim-plug 已安裝"
    else
        skip "vim-plug 已安裝"
    fi

    if [ ! -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" >/dev/null 2>&1
        "$HOME/.fzf/install" --all --no-bash --no-fish >/dev/null 2>&1
        ok "fzf 已安裝"
    else
        skip "fzf 已安裝"
    fi

    install_pkg rg ripgrep
    install_pkg uv uv
}

install_python_tools() {
    head_ "Python 開發工具"
    # 不用 --user：pyenv 的版本目錄本來就可寫，--user 會裝到
    # ~/Library/Python/<ver>/bin，那個路徑不在 PATH 上又會遮蔽 pyenv shims
    if pip3 install --quiet jedi ruff mypy 2>/dev/null; then
        command -v pyenv >/dev/null 2>&1 && pyenv rehash
        ok "jedi, ruff, mypy 已安裝（$(python3 -V 2>&1)）"
    else
        warn "pip3 安裝失敗，跳過"
    fi
}

# ====================
# update：拉最新的 repo 再重新套用
# ====================
cmd_update() {
    head_ "更新 repo"

    # 只看已追蹤檔案：未追蹤的檔案不影響 --ff-only，不該擋下更新
    local before after
    if [ -n "$(git status --porcelain --untracked-files=no)" ]; then
        warn "repo 有未 commit 的改動，跳過 git pull"
        git status --short --untracked-files=no | sed 's/^/      /'
    elif ! git remote get-url origin >/dev/null 2>&1; then
        warn "沒有設定 origin，跳過 git pull"
    else
        before="$(git rev-parse --short HEAD)"
        if git pull --ff-only >/dev/null 2>&1; then
            after="$(git rev-parse --short HEAD)"
            if [ "$before" = "$after" ]; then
                skip "已經是最新版 ($after)"
            else
                ok "已更新 $before -> $after"
                git --no-pager log --oneline "$before..$after" | sed 's/^/      /'
            fi
        else
            warn "git pull 失敗（可能需要 merge 或 rebase），請手動處理"
        fi
    fi

    link_dotfiles
    finish
}

# ====================
# status：只檢查，不修改
# ====================
check_cmd() {
    local cmd="$1" name="${2:-$1}"
    if command -v "$cmd" >/dev/null 2>&1; then
        ok "$name ${C_DIM}($(command -v "$cmd"))${C_OFF}"
    else
        warn "$name 未安裝"
    fi
}

cmd_status() {
    head_ "設定檔"
    local f src dst lf
    for f in $DOTFILES; do
        src="$SCRIPT_DIR/$f"
        dst="$HOME/$f"
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            ok "$f ${C_DIM}-> repo${C_OFF}"
        elif [ -L "$dst" ]; then
            warn "$f 連到別的地方: $(readlink "$dst")"
        elif [ -e "$dst" ]; then
            if cmp -s "$src" "$dst"; then
                warn "$f 是複製的檔案（內容相同，跑 link 可轉成 symlink）"
            else
                warn "$f 是複製的檔案，且內容和 repo 不同（跑 link 會先備份）"
            fi
        else
            warn "$f 不存在"
        fi
    done

    head_ "工具"
    check_cmd zsh
    check_cmd vim
    check_cmd git
    check_cmd tmux
    check_cmd rg ripgrep
    check_cmd fzf
    check_cmd uv
    check_cmd pyenv
    [ -d "$HOME/.oh-my-zsh" ] && ok "oh-my-zsh" || warn "oh-my-zsh 未安裝"
    [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] && ok "powerlevel10k" || warn "powerlevel10k 未安裝"
    [ -f "$HOME/.vim/autoload/plug.vim" ] && ok "vim-plug" || warn "vim-plug 未安裝"

    head_ "機器專屬設定（不進 repo）"
    for lf in .zprofile.local .zshrc.local.pre .zshrc.local; do
        if [ -f "$HOME/$lf" ]; then
            ok "~/$lf ${C_DIM}($(wc -l < "$HOME/$lf" | tr -d ' ') 行)${C_OFF}"
        else
            skip "~/$lf 未使用"
        fi
    done
    say ""
}

# ====================
finish() {
    printf '\n%s完成%s。設定檔是 symlink，改 repo 裡的檔案即刻生效。\n' "$C_BOLD" "$C_OFF"
    cat <<'EOF'

  exec zsh                    # 重新載入 shell
  vim +PlugUpdate +qall       # 更新 vim 插件
  tmux source ~/.tmux.conf    # 重新載入 tmux（tmux 內按 prefix + r 也可以）

機器專屬設定放這裡，不會被這個腳本動到：
  ~/.zprofile.local     登入 shell，非互動 shell 也需要的 PATH
  ~/.zshrc.local.pre    oh-my-zsh 之前（補完用的 fpath）
  ~/.zshrc.local        API key、機器專屬 PATH 與 alias
EOF
}

usage() {
    sed -n '3,11p' "$0" | sed 's/^#[[:space:]]\{0,1\}//'
}

# ====================
# 進入點
# ====================
case "${1:-install}" in
    install)
        install_omz
        install_tools
        link_dotfiles
        install_python_tools
        finish
        ;;
    update) cmd_update ;;
    link)   link_dotfiles; say "" ;;
    status) cmd_status ;;
    help|-h|--help) usage ;;
    *)
        say "未知的指令: $1"
        say ""
        usage
        exit 1
        ;;
esac
