require "core"
require "core.options"

vim.defer_fn(function()
   require("core.utils").load_mappings()
end, 0)

-- setup packer + plugins
require("core.packer").bootstrap()
-- require "plugins"
--

local user_conf, _ = pcall(require, "custom")

if user_conf then
   require "custom"
end

-- using vim in lua
vim.cmd[[
	syntax on
	filetype plugin indent on
	set nofoldenable
	set cindent
	set encoding=utf-8
	set foldmethod=indent   
	set foldnestmax=10
	set nofoldenable
	set foldlevel=2
	set encoding=utf-8
	set sts=4 "softabstop
	set ts=4 " tabstop
	set sw=4 " shiftwidth

	autocmd FileType * setlocal autoindent
]]
