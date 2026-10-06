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

" ========== 编码 ==========
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" ========== 界面 ==========
set laststatus=2              " 总是显示状态栏
set ruler                     " 显示光标位置
set scrolloff=5               " 光标距离上下边缘保留 5 行
set backspace=indent,eol,start " 退格键正常工作


" plugin 
call plug#begin()

" List your plugins here
Plug  'vim-airline/vim-airline'
Plug  'vim-airline/vim-airline-themes'

call plug#end()



let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
