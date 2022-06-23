syntax on
set number
set mouse=a
set numberwidth=1
set ruler
set encoding=utf-8
" set showmatch "is used to jump between brackets
"
set noshowmatch 
set clipboard=unnamed
set cindent
set path+=**
set sts=4 "softabstop
set ts=4 " tabstop
set sw=4 " shiftwidth
set hidden " hidden buffer off i.e. the buffer not is close
set signcolumn=yes
set laststatus=2

" Searching
set hlsearch "hightlight matches
set incsearch "incremental searching
"set infercase 
set cmdheight=1
set showcmd
set conceallevel=0 " edit markdown files enabled

filetype plugin indent on

set termguicolors
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" regions
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
" Imports 
"
" Setting Plug
source ~/AppData/Local/nvim/plugins.vim

source ~/AppData/Local/nvim/helpers.vim

source ~/AppData/Local/nvim/conf/nerdtree-lua.conf.vim

source ~/AppData/Local/nvim/conf/prettier.conf.vim

source ~/AppData/Local/nvim/conf/plugins.conf.vim

source ~/AppData/Local/nvim/conf/lualine.conf.vim

source ~/AppData/Local/nvim/conf/bufferline.conf.vim

source ~/AppData/Local/nvim/conf/fzf.conf.vim

source ~/AppData/Local/nvim/maps.vim

source ~/AppData/Local/nvim/conf/refactor-php.conf.vim

source ~/AppData/Local/nvim/conf/coc.conf.vim

source ~/AppData/Local/nvim/conf/xdebug.conf.vim

source ~/AppData/Local/nvim/conf/php.conf.vim

source ~/AppData/Local/nvim/conf/toggleterm.conf.vim

