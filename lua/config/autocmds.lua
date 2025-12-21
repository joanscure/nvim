local aug = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

au("FileType", {
  group = aug("fmtopts", {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

au("TextYankPost", { group = aug("yank", {}), callback = function()
  vim.highlight.on_yank({ timeout = 120 })
end })
