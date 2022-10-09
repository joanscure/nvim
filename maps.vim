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

" NERDTREE

nmap <c-p> :FZF -i<CR>
nmap <c-f> :Rg<CR>
nmap <c-s> :wall<CR>
nmap <leader>s :w<CR>
nmap <leader>bd :bd<CR>
nmap <leader>bb :Buffers<CR>
nnoremap <c-b> :NvimTreeFindFile<CR>

" RESIZE TAB
nnoremap <A-up> :resize -5<CR>
nnoremap <A-down> :resize +5<CR>
nnoremap <A-left> :vertical resize -5<CR>
nnoremap <A-right> :vertical resize +5<CR>
nmap <C-F6> :!start explorer /select,%:p<CR>

inoremap <silent>;; <end>;<End>

xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>
nmap <ESC> :noh<CR>
