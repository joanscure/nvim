local map, opts = vim.keymap.set, { noremap = true, silent = true }

map("n", "<Esc>", function()
  vim.cmd("noh")
  require("noice").cmd("dismiss")
end, opts)
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

-- Navegación entre splits/panes: ver christoomey/vim-tmux-navigator en editor.lua

map("n", "gl", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diags > 0 then
    local text = table.concat(vim.tbl_map(function(d) return d.message end, diags), "\n")
    vim.fn.setreg("+", text)
    vim.notify("Diagnóstico copiado al portapapeles", vim.log.levels.INFO)
  end
  vim.diagnostic.open_float(nil, { source = true })
end, { desc = "Ver diagnóstico (copia al portapapeles)" })
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

local function safe_terminal_paste()
  local text = (vim.fn.getreg("+") or ""):gsub("[\r\n]+", " ")
  vim.api.nvim_paste(text, false, -1)
end
map("t", "<C-v>", safe_terminal_paste, { desc = "Pegar (saneado) en terminal" })
map("t", "<C-S-v>", safe_terminal_paste, { desc = "Pegar (saneado) en terminal" })

