let mapleader= " "
" junegunn/vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" junegunn/gv.vim
vnoremap < <gv
vnoremap > >gv
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"moves in buffer
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>

inoremap jk <ESC>

" NERDTREE

nmap <c-p> :FZF -i<CR>
nmap <leader>f :Rg<CR>
nmap <leader>w :w<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bb :Buffers<CR>
nnoremap <leader>nd :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <c-f> :NvimTreeFindFile<CR>
nnoremap <silent>e :NvimTreeFindFile<CR>

" RESIZE TAB
nnoremap <A-up> :resize -5<CR>
nnoremap <A-down> :resize +5<CR>
nnoremap <A-left> :vertical resize -5<CR>
nnoremap <A-right> :vertical resize +5<CR>
nmap <C-F6> :!start explorer /select,%:p<CR>

noremap <leader>s :wall<CR>


inoremap <silent>;; <end>;<End>

" Delete highlight search
nmap <leader>/ :noh<CR>


"PRETTIER
function FormatPrettier()
  let fts = ['php']
  if (index(fts, &filetype) > -1)
    :PrettierPhp
  else 
    :Prettier
  endif
endfunction

"PRETTIER
nnoremap <leader>p :call FormatPrettier()<CR>
nmap <Leader>p :call FormatPrettier()<CR>


" EMMET
let g:user_emmet_leader_key='<c-y>'


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsSnippetDirectories=['../UltiSnips']
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsListSnippets="<C-_>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

