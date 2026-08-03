# dotfiles

個人開發環境設定檔，包含 Vim、Zsh、tmux、Git 等工具的配置。

## 快速開始

```bash
cd ~/.env
./setup.sh
```

腳本會自動安裝：
- oh-my-zsh + zsh-autosuggestions + zsh-syntax-highlighting
- powerlevel10k 主題
- vim-plug
- fzf + ripgrep
- uv (Python 套件管理)
- jedi, ruff, mypy (Python 開發工具)

並把所有 dotfiles **symlink** 到家目錄。改 repo 裡的檔案立刻生效，不需要重跑腳本。

## 指令

| 指令 | 用途 |
|------|------|
| `./setup.sh` | 等同 `install` |
| `./setup.sh install` | 安裝缺少的工具，並建立 symlink |
| `./setup.sh update` | `git pull`、重新套用設定、更新 oh-my-zsh／外掛／vim 插件 |
| `./setup.sh link` | 只重建 symlink，不安裝任何東西 |
| `./setup.sh status` | 檢查現況，不做任何修改 |

家目錄原本就存在的設定檔會先備份到 `~/.dotfiles-backup/<時間戳>/` 再換成 symlink。

## 安裝後設定

```bash
vim +PlugInstall +qall   # 安裝 Vim 插件
exec zsh                 # 重新載入 shell
```

## 機器專屬設定

不進 repo 的設定放這三個檔案，`setup.sh` 不會動到它們：

| 檔案 | 載入時機 | 放什麼 |
|------|----------|--------|
| `~/.zprofile.local` | 登入 shell | 非互動 shell 也需要的 PATH |
| `~/.zshrc.local.pre` | oh-my-zsh 之前 | 補完用的 `fpath` |
| `~/.zshrc.local` | `.zshrc` 最後 | API key、機器專屬 PATH 與 alias |

## 檔案說明

| 檔案 | 說明 |
|------|------|
| `.vimrc` | Vim 設定 |
| `.zshrc` | Zsh 設定 |
| `.p10k.zsh` | Powerlevel10k 主題設定 |
| `.tmux.conf` | Tmux 設定 |
| `.zprofile` | Zsh 登入 shell 設定（Homebrew、pyenv） |
| `.gitconfig` | Git 設定 |
| `setup.sh` | 環境安裝／更新腳本 |
| `VIM.md` | Vim 快捷鍵指南 |
| `CLAUDE.md` | Claude Code 專案記憶檔 |

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
