vim.g.mapleader = " "

-- Mapeos básicos
vim.api.nvim_set_keymap("n", "<ESC>", ":noh<CR>", { noremap = true, silent = true })

-- FZF para archivos y búsqueda
vim.keymap.set("n", "<C-p>", function()
  require("fzf-lua").files()
end, { noremap = true, silent = true, desc = "Buscar archivos" })

-- Buscar texto en el proyecto (con rg)
vim.keymap.set("n", "<C-f>", function()
  require("fzf-lua").live_grep_native() -- usa ripgrep optimizado
end, { noremap = true, silent = true, desc = "Buscar texto" })

-- Guardar todo y formateo
vim.api.nvim_set_keymap("n", "<C-s>", ":wall<CR>", { noremap = true, silent = true })

-- Buffers y NERDTree
vim.api.nvim_set_keymap("n", "<leader>x", ":bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bb", ":Buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>abd", ":%bd|e#|bd#<CR>", { noremap = true, silent = true })

-- NERDTree Toggle
vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Mapeos para mover líneas (similar a junegunn/gv.vim)
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Resolución de conflictos con Fugitive
vim.api.nvim_set_keymap("n", "<leader>gd", ":Gvdiff<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gdh", ":diffget //2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gdl", ":diffget //3<CR>", { noremap = true, silent = true })
