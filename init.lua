-- Configuración básica
vim.opt.syntax = "on"
vim.cmd("filetype plugin on")
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.numberwidth = 1
vim.opt.ruler = true
vim.opt.encoding = "utf-8"
vim.opt.showmatch = false
vim.opt.clipboard = "unnamed"
vim.opt.cindent = true
vim.opt.path:append("**")
vim.opt.sts = 2
vim.opt.ts = 2
vim.opt.sw = 2
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")

vim.opt.signcolumn = "yes"
vim.opt.laststatus = 2

-- Búsqueda
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.cmdheight = 1
vim.opt.showcmd = true

vim.opt.termguicolors = true
vim.cmd("highlight Normal ctermbg=NONE")

-- Opciones de formato
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})

-- Configuración de pliegues
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.foldlevel = 2

vim.cmd("filetype plugin indent on")

-- Python3 host
vim.g.python3_host_prog = 'C:\\Users\\joans\\AppData\\Local\\Programs\\Python\\Python312\\python.exe'

-- Cargar archivos de configuración adicionales como módulos Lua
require("config.lazy")
require("plugins.maps")
require("plugins.nerdtree-lua")
require("plugins.coc")
--require("plugins.lualine")
require("plugins.bufferline")
require("plugins.term")
-- require("plugins.fzf")  -- Descomenta si conviertes fzf a Lua
require("plugins.fzf") -- si tienes un archivo Lua para fzf
--require("plugins.surround")
--require("plugins.leap")
--require("plugins.colorscheme")
-- require("plugins.luasnip")  -- Descomenta si conviertes luasnip a Lua

-- Configuración de colores
--vim.g.ayucolor = "dark" -- para tema oscuro
--vim.cmd("colorscheme ayu")
