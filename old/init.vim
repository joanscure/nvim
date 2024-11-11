syntax on
filetype plugin on
set number
set mouse=a
set numberwidth=1
set ruler
set encoding=utf-8
"set fileformat=unix
set noshowmatch
set clipboard=unnamed
set cindent
set path+=**
set sts=2
set ts=2
set sw=2
set expandtab
set hidden
set updatetime=300
set shortmess+=c

set signcolumn=yes
set laststatus=2

" Searching
set hlsearch
set incsearch
set cmdheight=1
set showcmd

set termguicolors
highlight Normal ctermbg=NONE

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" regions
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

filetype plugin indent on

let g:python3_host_prog='C:\Users\joans\AppData\Local\Programs\Python\Python312\python.exe'

" Imports Scripts
source ~/AppData/Local/nvim/plug.vim
source ~/AppData/Local/nvim/plugins/maps.vim

source ~/AppData/Local/nvim/plugins/nerdtree-lua.vim
source ~/AppData/Local/nvim/plugins/coc.vim
source ~/AppData/Local/nvim/plugins/lualine.vim
source ~/AppData/Local/nvim/plugins/bufferline.vim
source ~/AppData/Local/nvim/plugins/term.vim
"source ~/AppData/Local/nvim/plugins/fzf.vim
source ~/AppData/Local/nvim/plugins/fzf.lua.vim
source ~/AppData/Local/nvim/plugins/surround-vim.vim
source ~/AppData/Local/nvim/plugins/leap.vim
source ~/AppData/Local/nvim/plugins/colorscheme.vim
"source ~/AppData/Local/nvim/plugins/luasnip.vim

"autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()

let ayucolor="dark"   " for dark version of theme
colorscheme ayu

