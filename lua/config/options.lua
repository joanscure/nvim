-- Opciones base y rendimiento
local o = vim.opt

-- Evita el módulo de Treesitter deprecado y usa la API nueva del plugin
vim.g.skip_ts_context_commentstring_module = true

-- Sensibles
o.clipboard = "unnamedplus"
o.termguicolors = true

-- UI
o.number = true
o.relativenumber = false
o.signcolumn = "yes"
o.cursorline = true
o.laststatus = 3 -- statusline global

-- Interacción
o.mouse = "a"
o.timeoutlen = 300

-- Búsqueda
o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

-- Indentación
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

-- Desempeño
o.updatetime = 200
o.lazyredraw = true

-- Pliegues por Treesitter (ufo opcional)
o.foldenable = false

-- Undo persistente
o.undofile = true

-- Desactiva providers que no uses (mejora startup)
vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.splitkeep = "screen"
