-- Asignación de teclas para abrir y cerrar ToggleTerm en modo normal e insert
vim.api.nvim_set_keymap('n', '<c-\\>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<c-\\>', '<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

-- Mapeo dentro del terminal para cerrar con Ctrl-\
vim.api.nvim_set_keymap('t', '<c-\\>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })

-- Asegurar que ToggleTerm funciona dentro del terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
        vim.api.nvim_buf_set_keymap(0, 't', '<c-\\>', '<Cmd>exe v:count1 . "ToggleTerm"<CR>', { noremap = true, silent = true })
    end,
})
