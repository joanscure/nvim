
" Configuracion de pluggins
call plug#begin('~/.vim/plugged')

" ide
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'yggdroot/indentline'
Plug 'editorconfig/editorconfig-vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
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

" nerdtree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/gv.vim'
Plug 'alvan/vim-closetag'

"git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} 
Plug 'junegunn/fzf.vim',
    "
" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Themes
Plug 'ghifarit53/tokyonight-vim'
Plug 'morhetz/gruvbox'
Plug 'projekt0n/github-nvim-theme'
Plug 'ryanoasis/vim-devicons'

" typing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'xabikos/vscode-javascript'
Plug 'pangloss/vim-javascript'
Plug 'eslint/eslint'
Plug 'StanAngeloff/php.vim'
Plug 'vim-python/python-syntax'
Plug 'jwalton512/vim-blade'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --frozen-lockfile --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

call plug#end()


" coc config
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint', 
      \ 'coc-json', 
      \ 'coc-css', 
      \ 'coc-emmet', 
      \ 'coc-html', 
      \ 'coc-blade', 
      \ 'coc-prisma', 
      \ 'coc-fzf-preview', 
      \ '@yaegassy/coc-intelephense', 
      \ 'coc-python', 
      \ 'coc-highlight',
      \ ]

