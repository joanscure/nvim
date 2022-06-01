call plug#begin('~/.vim/plugged')

" IDE 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'editorconfig/editorconfig-vim'
Plug 'gregsexton/MatchTag'
Plug 'pantharshit00/vim-prisma'
Plug 'github/copilot.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'mattn/emmet-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'sirver/ultisnips'
Plug 'vim-vdebug/vdebug'
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
Plug 'ryanoasis/vim-devicons'
" END THEMES

" TYPING
Plug 'tpope/vim-surround'
Plug 'eslint/eslint'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
" END TYPING
call plug#end()
