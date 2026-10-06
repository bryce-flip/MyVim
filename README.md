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

## 背景透明（80% 不透明）

`.vimrc` 已配好 vim 不绘制底色；透明度百分比在**终端模拟器**里设置：

- **GNOME Terminal**：Preferences → Profile → Colors → 透明滑块调到 20%，或：
  ```bash
  gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:<profile-id>/ background-transparency-percent 20
  ```
- **VSCode 集成终端**（settings.json，`cc` = 80% 不透明黑）：
  ```json
  "workbench.colorCustomizations": { "terminal.background": "#000000cc" }
  ```
- **Windows Terminal**（profile）：`"opacity": 80, "useAcrylic": true`

想要更透就把 20% 调大（VSCode 把 `cc` 改小）。
