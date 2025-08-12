local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

-- Quita auto comentarios al hacer nueva línea
au("FileType", {
  group = aug("fmtopts", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Resalta yank
au("TextYankPost", { group = aug("yank", {}), callback = function()
  vim.highlight.on_yank({ timeout = 120 })
end })
