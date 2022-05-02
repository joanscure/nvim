call plug#begin('~/.vim/plugged')

" IDE 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'yggdroot/indentline'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/vim-easy-align'
Plug 'gregsexton/MatchTag'
Plug 'sheerun/vim-polyglot'
Plug 'pantharshit00/vim-prisma'
Plug 'github/copilot.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mattn/emmet-vim'
" END IDE

" NERDTREE
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/gv.vim'
Plug 'alvan/vim-closetag'
" END NERDTREE

" GIT
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" END GIT

" FZF 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" END FZF

" STATUS BAR
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'
" END STATUS BAR

" THEMES
Plug 'ghifarit53/tokyonight-vim'
Plug 'morhetz/gruvbox'
Plug 'projekt0n/github-nvim-theme'
Plug 'ryanoasis/vim-devicons'
" END THEMES

" TYPING
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'xabikos/vscode-javascript'
Plug 'pangloss/vim-javascript'
Plug 'eslint/eslint'
Plug 'StanAngeloff/php.vim'
Plug 'vim-python/python-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" END TYPING
call plug#end()
