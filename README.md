## work-env：Docker 開發環境

一個可重現的 Ubuntu 16.04 容器化開發環境，內含 Vim、Zsh（oh-my-zsh + powerlevel10k）、tmux、Python3、Node.js、Go、Git 工具鏈，以及常用的 CLI 工具。透過 `docker-compose` 一鍵啟動，並提供 MySQL、Redis 服務與 SSH 存取。

### 需求條件
- 安裝 Docker 與 Docker Compose
- 建議系統：macOS/Linux

### 快速開始
```bash
cd ~/.env

# 建置並啟動開發環境容器
docker-compose up -d --build workenv

# 進入容器（Zsh）
docker-compose exec workenv zsh

# 或使用 SSH 連線（預設帳密：root / dockerpassword）
ssh root@localhost -p 22

# 停止並清除容器
docker-compose down
```

### 服務與連線資訊
- **workenv**: 主要開發容器
  - 掛載資料夾：將 `~/.env` 的上一層目錄掛載到容器的 `/volume`（見 `docker-compose.yml`）
  - 對外埠號：22（SSH）、8000、8091
  - SSH：`root:dockerpassword`（請於實際使用時修改）
- **mysql**: MySQL 5.7
  - 埠號：`3307 -> 3306`
  - 連線：`mysql -h 127.0.0.1 -P 3307 -u root -p123456`
- **redis**: Redis 5
  - 埠號：預設（未對映主機埠，容器間可互通）

### 容器內預裝工具（節錄）
- Shell/編輯器：Zsh、oh-my-zsh、powerlevel10k、Vim（含多種插件）、tmux
- 程式語言與工具：Python3、pip（使用者環境 `~/.local/bin`）、Node.js + npm、Go 1.13.6
- 開發輔助：git、git-flow、git-extras、ctags、cscope、cppcheck、tig、autojump、ripgrep/silversearcher-ag（ag）
- Python 常用套件：ipython、autopep8、pandas、ipdb、django、bs4、flake8
- OpenSSH Server（提供 SSH 登入）

完整安裝內容可參考 `Dockerfile`。

### 常用操作
```bash
# 重新建置（變更 Dockerfile 後）
docker-compose build workenv

# 查看容器日誌
docker-compose logs -f workenv

# 在容器中執行一次性指令
docker-compose exec workenv bash -lc "python3 --version"

# 只啟動/停止某一服務
docker-compose up -d mysql
docker-compose stop mysql
```

### 檔案/資料夾重點
- `Dockerfile`：定義開發環境映像檔內容
- `docker-compose.yml`：定義 `workenv`、`mysql`、`redis` 服務與對映埠、掛載
- `.zshrc`、`.p10k.zsh`：Zsh 與 powerlevel10k 設定
- `zsh_setting.sh`：設定 oh-my-zsh 與插件、常用 dotfiles
- `vim_compile.sh`：Vim 編譯參數（如需自編譯）
- `xdebug.ini`：PHP Xdebug 範例設定（若有需要）

### 相關文件
- `DEV_TOOL.md`：Commitizen、pre-commit、ripgrep、pyenv 等工具說明
- `VIM.md`：Vim 快捷鍵與插件操作筆記

### 安全性建議
- 啟用 SSH 後請務必修改預設密碼，或在私有網路中使用
- 調整 `docker-compose.yml` 的埠號對映，避免與本機服務衝突

### 疑難排解
- 找不到 `pip`/`ipython` 等指令：容器內已將 `~/.local/bin` 加入 `PATH`；若在非登入 Shell，請手動 `export PATH=$PATH:$HOME/.local/bin`
- SSH 無法連線：確認容器已啟動、埠號 22 已對映，或查看 `docker-compose logs -f workenv`
- 檔案掛載不到容器：注意 compose 中 `../:/volume` 係將 `~/.env` 的上一層目錄掛載至容器 `/volume`

---
如果你需要英文版 README 或想將文件分拆到 `docs/`，告訴我你偏好的結構與語言，我可以協助重構。
