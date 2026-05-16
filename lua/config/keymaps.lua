local map, opts = vim.keymap.set, { noremap = true, silent = true }

map("n", "<Esc>", ":noh<CR>", opts)
map("n", "<C-s>", ":wall<CR>", opts)

map("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Buffer siguiente" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Buffer anterior" })
for i = 1, 9 do
  map("n", string.format("<leader>%d", i), string.format(":BufferLineGoToBuffer %d<CR>", i), { silent = true, desc = "Ir a buffer " .. i })
end

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

map("n", "<C-h>", "<C-w>h", { desc = "Split izquierdo" })
map("n", "<C-j>", "<C-w>j", { desc = "Split abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Split arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Split derecho" })

map("n", "gl", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev,   { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,   { desc = "Next diagnostic" })

map("n", "<leader>dd", function() require("fzf-lua").diagnostics_document() end, { desc = "Diagnostics (buffer)" })
map("n", "<leader>dD", function() require("fzf-lua").diagnostics_workspace() end, { desc = "Diagnostics (workspace)" })

map("n", "gvd", function()
  if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then return end
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { desc = "Go to definition (vsplit)" })

-- Terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Salir de terminal mode" })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: moverse izquierda" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: moverse abajo" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: moverse arriba" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: moverse derecha" })
map("t", "<C-v>", '<C-\\><C-n>"+pi', { desc = "Pegar desde clipboard en terminal" })

