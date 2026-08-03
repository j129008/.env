# CLAUDE.md - 專案記憶檔

## 專案概述

這是個人 dotfiles 專案，包含 Vim、Zsh、tmux、Git 等開發環境設定。

## 專案結構

```
~/.env/
├── .vimrc               # Vim 設定
├── .zshrc               # Zsh 設定（互動 shell）
├── .zprofile            # Zsh 登入 shell 設定（Homebrew、pyenv）
├── .p10k.zsh            # Powerlevel10k 主題設定
├── .tmux.conf           # Tmux 設定
├── .gitconfig           # Git 設定
├── zsh_setting.sh       # 環境安裝腳本
├── VIM.md               # Vim 快捷鍵指南
├── README.md            # 專案說明文件
└── CLAUDE.md            # Claude Code 專案記憶檔
```

## 開發指引

### 編輯 Vim 設定時
- 主要編輯 `.vimrc`
- 更新設定後同步更新 `VIM.md` 說明文件
- 使用 vim-plug 管理插件
- Leader 鍵為 `,`

### 編輯 Shell 設定時
- Zsh 設定在 `.zshrc`
- Powerlevel10k 主題設定在 `.p10k.zsh`
- 安裝腳本在 `zsh_setting.sh`

## Commit 規範

使用 Conventional Commits 格式：
- `feat`: 新功能
- `fix`: 修復
- `docs`: 文件更新
- `refactor`: 重構
- `chore`: 雜項

範例：
```
docs(vim): update VIM.md with new shortcuts
refactor(vimrc): remove deprecated plugins
```

## 常用指令

```bash
# 安裝環境
cd ~/.env && ./zsh_setting.sh

# 安裝 Vim 插件
vim +PlugInstall +qall

# 重新載入 shell
exec zsh
```

## 注意事項

- 不要將敏感資訊 commit 到此 repo
- 修改 dotfiles 後執行 `./zsh_setting.sh` 同步到家目錄
- 修改後記得測試設定是否正常運作
- 機器專屬設定不要寫進 `.zshrc`，會被 `zsh_setting.sh` 覆蓋（會先備份到
  `~/.dotfiles-backup/<timestamp>/`，但仍應該放到下面的 local 檔案）

## 機器專屬設定與敏感資訊

不進 repo 的設定分兩個檔案，`.zshrc` 會自動載入：

| 檔案 | 載入時機 | 放什麼 |
| --- | --- | --- |
| `~/.zprofile.local` | `.zprofile` 最後（登入 shell） | 非互動 shell 也需要的機器專屬 PATH |
| `~/.zshrc.local.pre` | oh-my-zsh **之前** | `fpath` 補完設定、需要早一步生效的 PATH |
| `~/.zshrc.local` | `.zshrc` 最後 | API key、機器專屬 PATH 與 alias |

補完設定要放 `.pre` 是因為 oh-my-zsh 會執行 `compinit`：安裝程式（Docker、
OpenSpec 等）習慣在 `.zshrc` 尾端自己追加一次 `compinit`，每多一次就多一份
啟動成本。只加 `fpath`、讓 oh-my-zsh 統一跑一次即可。

```bash
# ~/.zshrc.local 範例
export OPENAI_API_KEY="sk-xxx"
export ANTHROPIC_API_KEY="sk-xxx"
```

`.zprofile` 負責 Homebrew 與 pyenv 的 `init --path`（登入 shell、非互動 shell
都會生效），所以 `.zshrc` 裡不需要再初始化 pyenv 一次。
