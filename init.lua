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
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType php setlocal autoindent

  function FormatPrettier()
    let fts = ['php']
    if (index(fts, &filetype) > -1)
      :PrettierPhp
    else 
      :Prettier
    endif
  endfunction
]]
