# CLAUDE.md - 專案記憶檔

## 專案概述

這是一個 Docker 開發環境設定檔專案，包含個人化的 dotfiles 和容器化開發環境。

## 專案結構

```
~/.env/
├── Dockerfile           # 開發環境映像檔
├── docker-compose.yml   # 服務編排 (workenv, mysql, redis)
├── .vimrc               # Vim 設定 (Linux/Container)
├── .vimrc_mac           # Vim 設定 (macOS)
├── VIM.md               # Vim 快捷鍵指南
├── .zshrc               # Zsh 設定
├── .p10k.zsh            # Powerlevel10k 主題設定
├── zsh_setting.sh       # Zsh/oh-my-zsh 安裝腳本
├── .tmux.conf           # Tmux 設定
├── .gitconfig           # Git 設定
├── DEV_TOOL.md          # 開發工具說明
└── README.md            # 專案說明文件
```

## 開發指引

### 編輯 Vim 設定時
- 主要編輯 `.vimrc`，macOS 版本為 `.vimrc_mac`
- 更新設定後同步更新 `VIM.md` 說明文件
- 使用 vim-plug 管理插件
- Leader 鍵為 `,`

### 編輯 Shell 設定時
- Zsh 設定在 `.zshrc`
- Powerlevel10k 主題設定在 `.p10k.zsh`
- 安裝腳本在 `zsh_setting.sh`

### Docker 相關
- 開發容器基於 Ubuntu 16.04
- 預設 SSH 密碼: `dockerpassword` (僅供開發用)
- MySQL 連線: `mysql -h 127.0.0.1 -P 3307 -u root -p123456`

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
# 啟動開發環境
docker-compose up -d --build workenv

# 進入容器
docker-compose exec workenv zsh

# 停止環境
docker-compose down
```

## 注意事項

- 不要將敏感資訊 commit 到此 repo
- `.vimrc` 會自動同步到 `~/.vimrc`
- 修改後記得測試設定是否正常運作
