-- Asignación de teclas para abrir y cerrar ToggleTerm
vim.api.nvim_set_keymap('n', '<silent><c-t>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<silent><c-t>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
vim.api.nvim_exec([[
  autocmd TermEnter term://*toggleterm#* tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
]], false)
