# MyVim

vim 配置仓库，vim-plug 管理插件。`~/.vimrc` 软链接到本仓库的 `.vimrc`，改仓库即生效。

## 新主机一键安装

```bash
curl -fsSL https://raw.githubusercontent.com/bryce-flip/MyVim/main/install.sh | bash
```

脚本会：备份并软链 `~/.vimrc` → 安装 vim-plug → `PlugInstall` 装插件。可重复执行（幂等）。

私有仓库或未配 HTTPS 访问时：

```bash
git clone git@github.com:bryce-flip/MyVim.git ~/MyVim && ~/MyVim/install.sh
```

## 日常维护

- 改配置：直接编辑本仓库 `.vimrc`，本机立即生效，`git push` 后其他主机 `git -C ~/MyVim pull` 即可
- 加插件：`.vimrc` 中加 `Plug '...'` 后执行 `:PlugInstall`，并提交 `.vimrc`
- 更新插件：vim 内 `:PlugUpdate`
