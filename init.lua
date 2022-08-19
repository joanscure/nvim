vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require "core"
require "core.options"

-- setup packer + plugins
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  print "Cloning packer .."
  fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

  -- install plugins + compile their configs
  vim.cmd "packadd packer.nvim"
  require "plugins"
  vim.cmd "PackerSync"
end

pcall(require, "custom")

require("core.utils").load_mappings()

-- using vim in lua
vim.cmd[[
	let g:python3_host_prog='C:\Users\joans\AppData\Local\Programs\Python\Python310\python.exe'
	let g:loaded_python3_provider='C:\Users\joans\AppData\Local\Programs\Python\Python310\python.exe'
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
	autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
	autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
]]
