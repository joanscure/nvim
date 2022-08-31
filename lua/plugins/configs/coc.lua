

vim.cmd [[
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
]]
vim.cmd [[ inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>" ]]


--Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice.
vim.cmd [[inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]]

vim.cmd [[
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
]]

--Use <c-k> to trigger completion.
vim.cmd[[ inoremap <silent><expr> <c-k> coc#refresh() ]]

vim.cmd[[
" coc config
let g:coc_global_extensions = [
      \ '@yaegassy/coc-intelephense', 
      \ 'coc-json', 
      \ 'coc-html', 
      \ 'coc-css', 
      \ 'coc-tsserver',
      \ 'coc-emmet',
      \ 'coc-angular',
      \ 'coc-phpls',
      \ 'coc-prettier',
      \ 'coc-diagnostic',
      \ 'coc-json',
      \ ]
]]
