local map, opts = vim.keymap.set, { noremap = true, silent = true }

-- Básicos
map("n", "<Esc>", ":noh<CR>", opts)
map("n", "<C-s>", ":wall<CR>", opts)

-- fzf-lua
-- map("n", "<C-p>", function() require("fzf-lua").files() end, { desc = "Buscar archivos" })
-- map("n", "<C-f>", function() require("fzf-lua").live_grep_native() end, { desc = "Buscar texto" })
-- map("n", "<leader>fb", function() require("fzf-lua").buffers() end, { desc = "Buffers" })
-- map("n", "<leader>fh", function() require("fzf-lua").help_tags() end, { desc = "Help" })


-- Bufferline (solo en NORMAL para no chocar con cmp en INSERT)
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Buffer siguiente" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Buffer anterior" })
for i = 1, 9 do
  map("n", string.format("<leader>%d", i), string.format(":BufferLineGoToBuffer %d<CR>", i), { silent = true, desc = "Ir a buffer " .. i })
end

-- Mover líneas
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Diagnostics (ver mensaje y navegar)
map("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev,   { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,   { desc = "Next diagnostic" })

-- Listas con fzf-lua
map("n", "<leader>dd", function() require("fzf-lua").diagnostics_document() end, { desc = "Diagnostics (buffer)" })
map("n", "<leader>dD", function() require("fzf-lua").diagnostics_workspace() end, { desc = "Diagnostics (workspace)" })

map("n", "gvd", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition (vsplit)" })

