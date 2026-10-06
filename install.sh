#!/usr/bin/env bash
# MyVim 一键安装脚本
# 用法:
#   1) 本地执行:          ./install.sh
#   2) 远程一键(公共仓库): curl -fsSL https://raw.githubusercontent.com/bryce-flip/MyVim/main/install.sh | bash
#   3) 私有仓库:          GH_TOKEN=<token> curl -fsSL -H "Authorization: token $GH_TOKEN" \
#                           https://raw.githubusercontent.com/bryce-flip/MyVim/main/install.sh | bash
#      或者直接:          git clone git@github.com:bryce-flip/MyVim.git ~/MyVim && ~/MyVim/install.sh
set -euo pipefail

REPO_HTTPS="https://github.com/bryce-flip/MyVim.git"
DEFAULT_CLONE_DIR="$HOME/MyVim"
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

msg() { printf '\033[1;32m==>\033[0m %s\n' "$*"; }
die() { printf '\033[1;31m错误:\033[0m %s\n' "$*" >&2; exit 1; }

# ---------- 管道模式 (curl | bash): 脚本从 stdin 读入, 无法定位仓库, 先克隆再自我调用 ----------
if [ ! -f "${BASH_SOURCE[0]}" ]; then
    if [ -d "$DEFAULT_CLONE_DIR/.git" ]; then
        msg "仓库已存在, 更新: $DEFAULT_CLONE_DIR"
        git -C "$DEFAULT_CLONE_DIR" pull --ff-only
    else
        msg "克隆仓库到 $DEFAULT_CLONE_DIR"
        if [ -n "${GH_TOKEN:-}" ]; then
            git clone "https://${GH_TOKEN}@github.com/bryce-flip/MyVim.git" "$DEFAULT_CLONE_DIR"
        else
            git clone "$REPO_HTTPS" "$DEFAULT_CLONE_DIR"
        fi
    fi
    exec bash "$DEFAULT_CLONE_DIR/install.sh" "$@"
fi

# ---------- 本地模式 ----------
REPO_DIR="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
VIMRC_SRC="$REPO_DIR/.vimrc"
VIMRC_DST="$HOME/.vimrc"
PLUG_VIM="$HOME/.vim/autoload/plug.vim"
PLUGGED_DIR="$HOME/.vim/plugged"

command -v vim >/dev/null 2>&1 || die "未找到 vim, 请先安装: sudo apt install vim"
[ -f "$VIMRC_SRC" ] || die "仓库中未找到 .vimrc ($VIMRC_SRC)"

# 1. 备份并软链 ~/.vimrc -> 仓库中的 .vimrc (vim 只读 ~/.vimrc, 软链保证改仓库即生效)
if [ "$(readlink "$VIMRC_DST" 2>/dev/null || true)" = "$VIMRC_SRC" ]; then
    msg "~/.vimrc 已链接到本仓库, 跳过"
else
    if [ -e "$VIMRC_DST" ] || [ -L "$VIMRC_DST" ]; then
        backup="$VIMRC_DST.bak.$(date +%Y%m%d%H%M%S)"
        mv "$VIMRC_DST" "$backup"
        msg "已备份原有配置: $backup"
    fi
    ln -s "$VIMRC_SRC" "$VIMRC_DST"
    msg "已链接 $VIMRC_DST -> $VIMRC_SRC"
fi

# 2. 安装 vim-plug (plug#begin 依赖 ~/.vim/autoload/plug.vim)
if [ -f "$PLUG_VIM" ]; then
    msg "vim-plug 已安装, 跳过"
else
    mkdir -p "$(dirname "$PLUG_VIM")"
    msg "下载 vim-plug..."
    if ! curl -fL "$PLUG_URL" -o "$PLUG_VIM"; then
        wget -qO "$PLUG_VIM" "$PLUG_URL" || die "vim-plug 下载失败, 请检查网络后重试"
    fi
    msg "vim-plug 安装完成"
fi

# 3. 安装插件 (--sync 保证非交互模式下同步装完再退出)
# 注意: vim -es 静默批处理模式下不自动加载 ~/.vimrc, 必须显式 -u 指定
msg "安装插件 (PlugInstall)..."
vim -n -es -u "$VIMRC_DST" +'PlugInstall --sync' +qall </dev/null

# 4. 校验: vimrc 能无报错加载, 且插件目录齐全
vim -n -es -Nu "$VIMRC_DST" +qall </dev/null || die "vimrc 加载报错, 请手动检查: vim ~/.vimrc"
expected=$(grep -cE "^\s*Plug\s" "$VIMRC_SRC" || true)
installed=$(find "$PLUGGED_DIR" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | wc -l)
if [ "$installed" -lt "$expected" ]; then
    die "插件安装不完整 ($installed/$expected), 请进入 vim 执行 :PlugStatus 检查"
fi
msg "完成: $expected/$expected 个插件就绪"
msg "打开 vim 即可使用; 更新插件用 :PlugUpdate"
