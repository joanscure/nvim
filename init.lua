if vim.loader then vim.loader.enable() end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.keymaps")