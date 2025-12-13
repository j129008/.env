# CLAUDE.md - 專案記憶檔

## 專案概述

這是個人 dotfiles 專案，包含 Vim、Zsh、tmux、Git 等開發環境設定。

## 專案結構

```
~/.env/
├── .vimrc               # Vim 設定
├── .vimrc_mac           # Vim 設定 (macOS 備份)
├── VIM.md               # Vim 快捷鍵指南
├── .zshrc               # Zsh 設定
├── .p10k.zsh            # Powerlevel10k 主題設定
├── zsh_setting.sh       # 環境安裝腳本
├── .tmux.conf           # Tmux 設定
├── .gitconfig           # Git 設定
├── DEV_TOOL.md          # 開發工具說明
└── README.md            # 專案說明文件
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
