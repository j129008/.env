# dotfiles

個人開發環境設定檔，包含 Vim、Zsh、tmux、Git 等工具的配置。

## 快速開始

```bash
cd ~/.env
./zsh_setting.sh
```

腳本會自動安裝：
- oh-my-zsh + zsh-autosuggestions + zsh-syntax-highlighting
- powerlevel10k 主題
- vim-plug
- uv (Python 套件管理)

並複製所有 dotfiles 到家目錄。

## 安裝後設定

```bash
vim +PlugInstall +qall   # 安裝 Vim 插件
exec zsh                 # 重新載入 shell
```

## 檔案說明

| 檔案 | 說明 |
|------|------|
| `.vimrc` | Vim 設定 |
| `.zshrc` | Zsh 設定 |
| `.p10k.zsh` | Powerlevel10k 主題設定 |
| `.tmux.conf` | Tmux 設定 |
| `.gitconfig` | Git 設定 |
| `VIM.md` | Vim 快捷鍵指南 |
| `DEV_TOOL.md` | 開發工具說明 |

## Vim 快捷鍵

詳見 [VIM.md](VIM.md)

常用：
- `,v` - 編輯 .vimrc
- `,h` - 開啟 Vim 指南
- `Ctrl-p` - 搜尋檔案 (fzf)
- `,f` - 全文搜尋 (ripgrep)
- `F9` - 執行當前檔案

## Tmux 快捷鍵

Prefix 鍵為 `Ctrl-a`

### Window 操作

| 快捷鍵 | 功能 |
|--------|------|
| `Option + ↑` | 上一個 window |
| `Option + ↓` | 下一個 window |
| `Ctrl-a c` | 新增 window |
| `Ctrl-a a` | 重新命名 window |
| `Ctrl-a k` | 關閉 window |

### Pane 操作

| 快捷鍵 | 功能 |
|--------|------|
| `Ctrl-a s` | 水平分割 |
| `Ctrl-a v` | 垂直分割 |
| `Ctrl-a h/j/k/l` | 切換 pane (vim 風格) |
| `Ctrl-a </>/-/+` | 調整 pane 大小 |

### 其他

| 快捷鍵 | 功能 |
|--------|------|
| `Ctrl-a :` | 命令模式 |
| `Ctrl-a [` | 複製模式 (vi 操作) |

## Python 套件管理 (uv)

```bash
uv venv                    # 建立虛擬環境
uv pip install <package>   # 安裝套件
uv run python script.py    # 執行腳本
```
