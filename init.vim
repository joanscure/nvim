syntax on
filetype plugin on
set number
set mouse=a
set numberwidth=1
set ruler
set encoding=utf-8

set noshowmatch
set clipboard=unnamed
set cindent
set path+=**
set sts=2
set ts=2
set sw=2
set hidden
set updatetime=300

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

let g:python3_host_prog='C:\Users\joans\AppData\Local\Programs\Python\Python310\python.exe'

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart 
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Imports Scripts
source ~/AppData/Local/nvim/plug.vim
source ~/AppData/Local/nvim/plugins/maps.vim

source ~/AppData/Local/nvim/plugins/nerdtree-lua.vim
source ~/AppData/Local/nvim/plugins/coc.vim
source ~/AppData/Local/nvim/plugins/lualine.vim
source ~/AppData/Local/nvim/plugins/bufferline.vim
source ~/AppData/Local/nvim/plugins/term.vim
source ~/AppData/Local/nvim/plugins/fzf.vim
source ~/AppData/Local/nvim/plugins/vimspector.vim

let g:gruvbox_termcolors=16
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='soft'
colorscheme gruvbox
