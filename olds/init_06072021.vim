

" Configuracion de pluggins
call plug#begin('~/.vim/plugged')
Plug 'yggdroot/indentline'   
Plug 'xabikos/vscode-javascript'
"Plug 'KarimElghamry/vim-auto-comment'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'nicwest/vim-http'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'junegunn/gv.vim'
Plug 'sheerun/vim-polyglot'

"Plug 'ghifarit53/tokyonight-vim'

"Plug 'crusoexia/vim-monokai'

Plug 'terryma/vim-multiple-cursors'
Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() }} 
Plug 'junegunn/fzf.vim',
    "
" status bar
Plug 'maximbaz/lightline-ale'
Plug 'itchyny/lightline.vim'

" Themes
"Plug 'morhetz/gruvbox'
"Plug 'shinchu/lightline-gruvbox.vim'
" typing
"Plug 'jiangmiao/auto-pairs'
"Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'mattn/emmet-vim'
"
" news
Plug 'pangloss/vim-javascript'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

inoremap jk <ESC>
let mapleader= " "
let NerdTreeQuitOnOpen=1
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-w> :NERDTreeFind<CR>
nmap <leader>nd :NERDTree<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
nmap <C-p> :FZF -i<CR>
nmap <leader>rg :Rg<CR>
nmap <leader>w :w<CR>
nmap <leader>bd :bd<CR>
nmap <leader>/ :noh<CR>
" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
let g:airline_powerline_fonts = 1
"autocmd VimEnter * NERDTree
 let NERDTreeShowHidden=1
 let NERDTreeQuitOnOpen=1
 let NERDTreeAutoDeleteBuffer=1
 let NERDTreeMinimalUI=1
 let NERDTreeDirArrows=1
 let NERDTreeShowLineNumbers=1
 let g:NERDTreeGitStatusWithFlags = 1
 let g:WebDevIconsUnicodeDecorateFolderNodes = 1
 let g:NERDTreeGitStatusNodeColorization = 1
 let g:NERDTreeColorMapCustom = {
    \ "Staged"    : "#0ee375",  
    \ "Modified"  : "#d9bf91",  
    \ "Renamed"   : "#51C9FC",  
    \ "Untracked" : "#FCE77C",  
    \ "Unmerged"  : "#FC51E6",  
    \ "Dirty"     : "#FFBD61",  
    \ "Clean"     : "#87939A",   
    \ "Ignored"   : "#808080"   
    \ }                         
let g:NERDTreeIgnore = ['^node_modules$']
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.


let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" coc config
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-angular', 
  \ 'coc-blade-linter', 
  \ 'coc-css', 
  \ 'coc-emmet', 
  \ 'coc-html', 
  \ 'coc-html-css-support', 
  \ '@yaegassy/coc-intelephense', 
  \ 'coc-python', 
  \ 'coc-phpls', 
  \ 'coc-highlight'
  \ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
 
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" eliminar vista de autocompletado en el caso que se bugee.
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <F2> <Plug>(coc-rename)
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)


" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" my pluggins
vnoremap < <gv
vnoremap > >gv

let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.jsx, *.js'

" Config multi cursors
let g:multi_cursor_use_default_mapping=0

let g:nulti_cursor_start_word_key      = '<C-t>'
" let g:multi_cursor_select_all_word_key = '<A-d>'
 let g:multi_cursor_start_key           = 'g<C-t>'
let g:multi_cursor_select_all_key      = 'g<A-t>'
let g:multi_cursor_next_key            = '<C-t>'
 let g:multi_cursor_prev_key            = '<C-;>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

"configuracion de tabs

let g:indentLine_enabled = 1
let g:indentLine_char = '▏'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude=["nerdtree"]
let g:indentLine_fileType = ['html']
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
      \   'right': [['filetype', 'percent', 'lineinfo'], ['gitbranch']]
      \ },
      \ 'inactive': {
      \   'left': [['inactive'], ['relativepath']],
      \   'right': [['bufnum']]
      \ },
      \ 'component': {
      \   'bufnum': '%n',
      \   'inactive': 'inactive'
      \ },
      \ 'component_function': {
      \ },
 	  \ 'colorscheme': 'PaperColor',
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}

"auto commentado
let g:inline_comment_dict = {
	\'//': ["js", "ts", "cpp", "c", "dart","css","scss"],
	\'#': ['py', 'sh', 'php'],
	\'"': ['vim'],
	\}
let g:block_comment_dict = {
		\'/*': ["js", "ts", "cpp", "c", "dart"],
		\'"""': ['py'],
        \'<!--':['html'],
		\}
" correr con node el fichero actual
nnoremap <Leader>x :!node %<cr>

" configuracion general
set number
set mouse=a
set numberwidth=1
set showcmd
set ruler
set encoding=utf-8
set relativenumber
set showmatch
syntax on
filetype plugin indent on
set sw=4
set clipboard=unnamed
set cindent
set tabstop=4
" set shiftwidth=4
" set showtabline=2
" set expandtab

" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set autoread
set signcolumn=yes
set updatetime=300

" colorscheme gruvbox
" highlight Normal ctermbg=NONE
set laststatus=2
set noshowmode

" HTML, JSX
let g:closetag_filenames = '*.html,*.js,*.jsx,*.ts,*.tsx'

" Javascript
"autocmd bufnewfile,bufread *.tsx set filetype=typescript.tsx
"autocmd bufnewfile,bufread *.ts set filetype=typescript.tsx
"autocmd bufnewfile,bufread *.jsx set filetype=javascript.jsx
"autocmd bufnewfile,bufread *.js set filetype=javascript.jsx

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
" set smartcase                   " ... unless they contain at least one capital letter
set infercase
set cmdheight=1
set termguicolors

" let g:tokyonight_style = 'night' " available: night, storm
" let g:tokyonight_enable_italic = 0

set background=dark
colorscheme PaperColor
"colorscheme monokai

set conceallevel=1
