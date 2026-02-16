local o = vim.opt

vim.g.skip_ts_context_commentstring_module = true

o.clipboard = "unnamedplus"
o.termguicolors = true

o.number = true
o.relativenumber = false
o.signcolumn = "yes"
o.cursorline = true
o.laststatus = 3 

o.mouse = "a"
o.timeoutlen = 300

o.ignorecase = true
o.smartcase = true
o.incsearch = true
o.hlsearch = true

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2

o.updatetime = 200

o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }

o.undofile = true

vim.g.loaded_node_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.splitkeep = "screen"
