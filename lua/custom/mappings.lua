---@type MappingsTable
local M = {}


M.general = {

   i = {
    ["<A-j>"] = { ":m '<Esc>:m .+1<CR>==gi", "move current line to down",opts = { noremap = true }},
     ["<A-k>"] = { ":m '<Esc>:m .-2<CR>==gi", "move current line to up", opts = { noremap = true } },
   },

   n = {

     ["<A-j>"] = { ":m .+1<CR>==", "move current segment line to down", opts = { noremap = true }},
     ["<A-k>"] = { ":m .-2<CR>==", "move current segment line to up",  opts = { noremap = true } },
   },

   v = {
     ["<"] = { "<gv", "move to current line to right",opts = { noremap = true }},
     [">"] = { ">gv", "move to current line to left",opts = { noremap = true }},
     ["<A-j>"] = { ":m '>+1<CR>gv=gv", "move current segment line to down, (visual mode)", opts = { noremap = true }},
     ["<A-k>"] = { ":m '<-2<CR>gv=gv", "move current segment line to up (visual mode)", opts = { noremap = true } },
   }
}
-- more keybinds!

return M
