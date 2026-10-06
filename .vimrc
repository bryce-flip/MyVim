" ~/.vimrc
" ========== 基础设置 ==========
set nocompatible              " 不兼容 vi 模式
syntax on                     " 语法高亮
filetype plugin indent on     " 自动识别文件类型

set number                    " 显示行号
set relativenumber            " 显示相对行号
set cursorline                " 高亮当前行
set showcmd                   " 显示命令
set showmatch                 " 括号匹配
set wildmenu                  " 命令行补全

" ========== 缩进 ==========
set tabstop=4                 " Tab 宽度
set shiftwidth=4              " 自动缩进宽度
set expandtab                 " Tab 转空格
set autoindent                " 自动缩进
set smartindent               " 智能缩进

" ========== 搜索 ==========
set incsearch                 " 实时搜索
set hlsearch                  " 高亮搜索结果
set ignorecase                " 忽略大小写
set smartcase                 " 智能大小写

" ========== 背景透明 ==========
" vim 不绘制自身背景色, 露出终端的透明背景 (透明度百分比在终端模拟器里设置, 见 README)
augroup transparent_bg
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight NonText ctermbg=NONE guibg=NONE
augroup END
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE

" ========== 编码 ==========
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" ========== 界面 ==========
set laststatus=2              " 总是显示状态栏
set ruler                     " 显示光标位置
set scrolloff=5               " 光标距离上下边缘保留 5 行
set backspace=indent,eol,start " 退格键正常工作

" ========== Leader 键 ==========
" 注: Ctrl 是修饰键, 终端不会为单独按下它发送按键码, 无法作为 leader
" 此处用空格作 leader, 想改逗号/分号只需改下面这行
let mapleader = " "

nnoremap <leader>w :w<CR>       " 空格+w 保存
nnoremap <leader>q :q<CR>       " 空格+q 退出
nnoremap <leader>/ :nohlsearch<CR> " 空格+/ 清除搜索高亮 (h 让给跳转了)



" 按住 Ctrl 连续点按 hjkl 同样跳 10 行/列 (空格是字符键无法按住, Ctrl 是真修饰键)
nnoremap <C-j> <Cmd>execute 'normal! ' . (v:count ? v:count * 10 : 10) . 'j'<CR>
nnoremap <C-k> <Cmd>execute 'normal! ' . (v:count ? v:count * 10 : 10) . 'k'<CR>
nnoremap <C-h> <Cmd>execute 'normal! ' . (v:count ? v:count * 10 : 10) . 'h'<CR>
nnoremap <C-l> <Cmd>execute 'normal! ' . (v:count ? v:count * 10 : 10) . 'l'<CR>


" plugin
call plug#begin()

" List your plugins here
Plug  'vim-airline/vim-airline'
Plug  'vim-airline/vim-airline-themes'

call plug#end()



let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'

" ========== 配色 ==========
" snazzy 已 vendor 进本仓库 colors/ 目录, 不依赖外部插件 (上游 2020 年停更)
" 注意必须先 resolve 软链再取目录: ~/.vimrc 是软链, 先 :h 会得到 /home/bryce
execute 'set runtimepath+=' . fnamemodify(resolve(expand('<sfile>:p')), ':h')
" 注意顺序: g:SnazzyTransparent 必须在 colorscheme 之前设置 (方案加载时读取)
let g:SnazzyTransparent = 1     " 打开即不绘制底色, 露出终端透明背景
colorscheme snazzy
