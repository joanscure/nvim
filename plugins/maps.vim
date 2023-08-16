let mapleader= " "

xnoremap <silent> p p:let @+=@0<CR>:let @"=@0<CR>
nmap <ESC> :noh<CR>

nmap <C-F6> :!start explorer /select,%:p<CR>

nmap <c-p> :FZF -i<CR>
nmap <c-f> :Rg!

nmap <c-s> :wall<CR>
nmap <leader>s :w<CR>

nmap <leader>bd :bd<CR>
nmap <leader>bb :Buffers<CR>
" close all buffer but this one
nmap <leader>abd :%bd\|e#\|bd#<cr><CR> 

" NERDTREE
nnoremap <c-b> :NvimTreeToggle<CR>

" junegunn/gv.vim
vnoremap < <gv
vnoremap > >gv
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Nerd Commenter
let g:NERDCreateDefaultMappings = 0

nmap  <leader>cc <plug>NERDCommenterToggle
vnoremap <leader>cc <plug>NERDCommenterToggle

imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
