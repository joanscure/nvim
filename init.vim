" Configuracion de ubicacion de python
source ~/AppData/Local/nvim/config/python.vim
" Config Vim
source ~/AppData/Local/nvim/config/config.vim
" Install Plug
source ~/AppData/Local/nvim/config/plugins.vim

" FZF
let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'

let $PATH = "C:/Program Files/Git/usr/bin;". $PATH
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Label'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }




command! -bang -nargs=? -complete=dir GFiles
      \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"let g:prettier#autoformat = 1
"
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0

let g:coc_current_word_highlight_delay = 0
"let g:coc_current_word_filetypes = ['*']  " enable for all filtypes by default
"autocmd BufAdd NERD_tree_*,your_buffer_name.rb,*.js :let b:coc_current_word_disabled_in_this_buffer = 1

" Max line length that prettier will wrap on: a number or 'auto' (use
" textwidth).
" default: 'auto'
let g:prettier#config#print_width = 'auto'

" number of spaces per indentation level: a number or 'auto' (use
" softtabstop)
" default: 'auto'
let g:prettier#config#tab_width = 'auto'

" use tabs instead of spaces: true, false, or auto (use the expandtab setting).
" default: 'auto'
let g:prettier#config#use_tabs = 'auto'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty string
" (let prettier choose).
" default: ''
let g:prettier#config#parser = ''

" cli-override|file-override|prefer-file
" default: 'file-override'
let g:prettier#config#config_precedence = 'file-override'

" always|never|preserve
" default: 'preserve'
let g:prettier#config#prose_wrap = 'preserve'

" css|strict|ignore
" default: 'css'
let g:prettier#config#html_whitespace_sensitivity = 'css'

" false|true
" default: 'false'
let g:prettier#config#require_pragma = 'false'

" Define the flavor of line endings
" lf|crlf|cr|all
" defaut: 'lf'
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')

let g:coc_default_semantic_highlight_groups = 1

let mapleader= " "
let NerdTreeQuitOnOpen=1

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
"
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
"if has('nvim')
inoremap <silent><expr> <C-k> coc#refresh()
"else
  "inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()
"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gf <Nop>
nmap <silent> gvd :vsplit<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" eliminar vista de autocompletado en el caso que se bugee.
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
"xmap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap if <Plug>(coc-funcobj-i)
"omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

inoremap jk <ESC>
"open nerd tree
nmap <leader>nd :NERDTreeToggle<CR>
"find nerdtree
nmap <C-f> :NERDTreeFind<CR>
"search file
nmap <C-p> :FZF -i<CR>
"search word
nmap <leader>f :Rg<CR>
"save 
nmap <leader>w :w<CR>
"delete buffer
nmap <leader>bd :bd<CR>
"open buffer
nmap <leader>bb :Buffers<CR>

" Prettier
nmap <Leader>p <Plug>(Prettier)

" resize tab

nnoremap <A-up> :resize -5<CR>
nnoremap <A-down> :resize +5<CR>
nnoremap <A-left> :vertical resize -5<CR>
nnoremap <A-right> :vertical resize +5<CR>
nmap <F6> :!start explorer /select,%:p<CR>
nmap <F5> :e $MYVIMRC<CR>


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"search
nmap <leader>/ :noh<CR>

"Nerd Config
let g:airline_powerline_fonts = 1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
"let NERDTreeShowLineNumbers=1
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
let g:NERDTreeIgnore = ['^node_modules$', 'vendor']
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction


" my pluggins
vnoremap < <gv
vnoremap > >gv

"up and down lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
autocmd FileType scss setl iskeyword+=@-@

"Config auto close files
let g:closetag_filenames = '*.html,*blade.php,*.phtml, *.jsx'

"configuracion de tabs

let g:indentLine_enabled = 1
let g:indentLine_char = '¦'
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude=["nerdtree"]
"moves in buffer
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>



let g:lightline = {
      \ 'active': {
      \   'left': [['mode', 'paste'], [], ['relativepath', 'modified']],
      \   'right': [['kitestatus'], ['filetype', 'percent', 'lineinfo'], ['gitbranch']]
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
      \   'gitbranch': 'fugitive#head',
      \   'kitestatus': 'kite#statusline'
      \ },
      \ 'colorscheme': 'tokyonight',
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
      \}                

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }
let g:lightline#ale#indicator_checking = "\uf109"
let g:lightline#ale#indicator_infos = "\uf128"
let g:lightline#ale#indicator_warnings = "\uf070"
let g:lightline#ale#indicator_errors = "\uf04e"
let g:lightline#ale#indicator_ok = "\uf-01c"

" correr con node el fichero actual
" 
"nnoremap <Leader>x :!node %<cr>
" run files types
"



"set background=dark 
"set theme ide
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_termcolors=16
let g:gruvbox_contrast_light='hard'
"colorscheme gruvbox
colorscheme tokyonight
highlight Normal ctermbg=NONE

let g:tokyonight_style='night' " available: night, storm
let g:tokyonight_current_word='bold'
let g:tokyonight_enable_italic = 1



"colorscheme github_dark_default

"let g:airline_theme='codedark'
"let g:codedark_conservative=1


"let g:javascript_plugin_jsdoc = 1

"let g:javascript_plugin_ngdoc = 1

"let g:javascript_plugin_flow = 1
"augroup javascript_folding
      "au!
      "au FileType javascript setlocal foldmethod=syntax
"augroup END
"
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


augroup exe_code
      autocmd!
      "
      "Execute python code
      autocmd FileType python nnoremap <buffer> <leader>x
                        \ :sp<CR> :term py %<CR> :startinsert<CR>

      "Execute bash code
      autocmd FileType javascript nnoremap <buffer> <leader>x
                        \ :sp<CR> :term node %<CR> :startinsert<CR>

      "Execute bash code
      autocmd FileType bash,sh nnoremap <buffer> <leader>x
                        \ :sp<CR> :term bash %<CR> :startinsert<CR>
augroup END

