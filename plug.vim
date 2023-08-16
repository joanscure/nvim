call plug#begin('~/.vim/plugged')

" IDE
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'puremourning/vimspector'
Plug 'mhartington/oceanic-next'
Plug 'windwp/nvim-autopairs'
Plug 'voldikss/vim-translator'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/gv.vim'
Plug 'alvan/vim-closetag'

" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" FZF 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" TYPING
Plug 'tpope/vim-surround'

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
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'udalov/kotlin-vim'

call plug#end()
