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
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>

inoremap jk <ESC>

" NERDTREE
nmap <leader>nd :NERDTreeToggle<CR>
nmap <c-f> :NERDTreeFind<CR>
nmap <c-p> :FZF -i<CR>
nmap <leader>f :Rg<CR>
nmap <leader>w :w<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bb :Buffers<CR>


" RESIZE TAB
nnoremap <A-up> :resize -5<CR>
nnoremap <A-down> :resize +5<CR>
nnoremap <A-left> :vertical resize -5<CR>
nnoremap <A-right> :vertical resize +5<CR>
nmap <F6> :!start explorer /select,%:p<CR>
nmap <F5> :e $MYVIMRC<CR>

noremap <silent>ss :wall<CR>
inoremap <silent>;; <end>;<End>


function FormatPrettier()
  let fts = ['php']
  if (index(fts, &filetype) > -1)
    :PrettierPhp
  else 
    :Prettier
  endif
endfunction

nnoremap <leader>p :call FormatPrettier()<CR>
nmap <Leader>p :call FormatPrettier()<CR>

let g:user_emmet_leader_key='<c-y>'
