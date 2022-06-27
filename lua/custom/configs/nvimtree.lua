local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

require("base46").load_highlight "nvimtree"

local options = {
   filters = {
      dotfiles = false,
      custom = {'.git', '.github', '^node_modules$', 'vendor'}
   },
   disable_netrw = true,
   hijack_netrw = true,
   open_on_setup = false,
   ignore_ft_on_setup = { "alpha" },
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      side = "left",
      width = 25,
      hide_root_folder = true,
   },
   git = {
      enable = true,
      ignore = false,
   },
   actions = {
      open_file = {
         quit_on_open = true,
         resize_window = true,
      },
      remove_file = {
        close_window = true,
      },
   },
   renderer = {
      highlight_git = false,
      highlight_opened_files = "none",

      indent_markers = {
         enable = false,
      },

      icons = {
         show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
         },

         glyphs = {
            default = "",
            symlink = "",
            folder = {
               default = "",
               empty = "",
               empty_open = "",
               open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               unstaged = "✗",
               staged = "✓",
               unmerged = "",
               renamed = "➜",
               untracked = "★",
               deleted = "",
               ignored = "◌",
            },
         },
      },
      special_files = { ".env", "Makefile", "README.md", "readme.md", 'Dockerfile' },
   },
    log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
    },
}

-- check for any override
options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")

nvimtree.setup(options)
