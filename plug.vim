call plug#begin('~/.vim/plugged')

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'NvChad/nvim-colorizer.lua'
"Plug 'windwp/nvim-autopairs'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/gv.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-repeat'
Plug 'Exafunction/codeium.vim'
Plug 'ggandor/leap.nvim'
Plug 'ayu-theme/ayu-vim' 

" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" FZF 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" TYPING
Plug 'kylechui/nvim-surround'
Plug 'prisma/vim-prisma'

Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'gregsexton/MatchTag'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" Langs
Plug 'dart-lang/dart-vim-plugin'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
"Plug 'udalov/kotlin-vim'

call plug#end()
