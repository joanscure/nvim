set number
set mouse=a
set numberwidth=1
set ruler
set encoding=utf-8
set showmatch "is used to jump between brackets
set clipboard=unnamed
set cindent
set path+=**
"set sts=2 "softabstop
"set ts=2 "tabstop
"set sw=8 "shiftwidth
set hidden " hidden buffer off i.e. the buffer not is close
set signcolumn=yes
set laststatus=2

" Searching
set hlsearch "hightlight matches
set incsearch "incremental searching
"set infercase 
set cmdheight=1
set termguicolors
set showcmd
set conceallevel=0 " edit markdown files enabled

filetype plugin indent on
syntax on

" Imports 
"
" Setting Plug
source ~/AppData/Local/nvim/conf/plugins.vim

source ~/AppData/Local/nvim/conf/helpers.vim

source ~/AppData/Local/nvim/conf/lightline-conf.vim

source ~/AppData/Local/nvim/conf/nerdtree-conf.vim

source ~/AppData/Local/nvim/conf/prettier-conf.vim

source ~/AppData/Local/nvim/conf/plugins-conf.vim

source ~/AppData/Local/nvim/conf/fzf-conf.vim

source ~/AppData/Local/nvim/conf/maps.vim

source ~/AppData/Local/nvim/conf/coc-conf.vim

