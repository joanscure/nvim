local api = vim.api
local opt = vim.opt

local g = vim.g

opt.clipboard = "unnamedplus"
opt.cul = false

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.foldnestmax = 10
opt.foldlevel = 2

-- Numbers
opt.number = true
opt.numberwidth = 1
opt.ruler = false

opt.fillchars = { eob = " "}
opt.smartcase = true
opt.mouse = "a"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- Extra
opt.syntax = "on"
opt.encoding = "utf-8"
opt.sts = 4
opt.ts = 4
opt.sw = 4
opt.cindent = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- coc

--Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
--delays and poor user experience.
opt.updatetime=300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
opt.signcolumn="yes"

g.mapleader = " "


-- install default plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

-- default install providers
local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end



