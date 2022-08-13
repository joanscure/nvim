-- example file i.e lua/custom/init.lua
vim.cmd "packadd packer.nvim"

local plugins = {

   ["nvim-lua/plenary.nvim"] = { module = "plenary" },
   ["wbthomason/packer.nvim"] = {},
   ["NvChad/extensions"] = { module = { "telescope", "nvchad" } },

   ["NvChad/base46"] = {
      config = function()
         local ok, base46 = pcall(require, "base46")

         if ok then
            base46.load_theme()
         end
      end,
   },

   ["NvChad/nvterm"] = {
      module = "nvterm",
      config = function()
         require "custom.configs.nvterm"
      end,
   },

   ["kyazdani42/nvim-web-devicons"] = {
      module = "nvim-web-devicons",
      config = function()
         require("custom.configs.others").devicons()
      end,
   },

   ["lukas-reineke/indent-blankline.nvim"] = {
      opt = true,
      setup = function()
         require("core.lazy_load").on_file_open "indent-blankline.nvim"
      end,
      config = function()
         require("custom.configs.others").blankline()
      end,
   },

   ["NvChad/nvim-colorizer.lua"] = {
      opt = true,
      setup = function()
         require("core.lazy_load").colorizer()
      end,
      config = function()
         require("custom.configs.others").colorizer()
      end,
   },

   ["nvim-treesitter/nvim-treesitter"] = {
      module = "nvim-treesitter",
      setup = function()
         require("core.lazy_load").on_file_open "nvim-treesitter"
      end,
      cmd = require("core.lazy_load").treesitter_cmds,
      run = ":TSUpdate",
      config = function()
         require "custom.configs.treesitter"
      end,
   },

   -- git stuff
   -- ["lewis6991/gitsigns.nvim"] = {
   --    opt = true,
   --    setup = function()
   --       require("core.lazy_load").gitsigns()
   --    end,
   --    config = function()
   --       require("custom.configs.others").gitsigns()
   --    end,
   -- },
   ["airblade/vim-gitgutter"] = {},
   ["tpope/vim-fugitive"] = {},

   -- lsp stuff

   ["williamboman/nvim-lsp-installer"] = {
      opt = true,
      cmd = require("core.lazy_load").lsp_cmds,
      setup = function()
         require("core.lazy_load").on_file_open "nvim-lsp-installer"
      end,
   },

   ["neovim/nvim-lspconfig"] = {
      after = "nvim-lsp-installer",
      module = "lspconfig",
      config = function()
         require "custom.configs.lsp_installer"
         require "custom.configs.lspconfig"
      end,
   },

   -- load luasnips + cmp related in insert mode only

   ["rafamadriz/friendly-snippets"] = {
      module = "cmp_nvim_lsp",
      event = "InsertEnter",
   },

   ["hrsh7th/nvim-cmp"] = {
      after = "friendly-snippets",
      config = function()
         require "custom.configs.cmp"
      end,
   },

   ["L3MON4D3/LuaSnip"] = {
      wants = "friendly-snippets",
     after = "nvim-cmp",
      config = function()
         require("custom.configs.others").luasnip()
      end,

   },

   ["saadparwaiz1/cmp_luasnip"] = {
      after = "LuaSnip",
   },

   ["hrsh7th/cmp-nvim-lua"] = {
      after = "cmp_luasnip",
   },

   ["hrsh7th/cmp-nvim-lsp"] = {
      after = "cmp-nvim-lua",
   },

   ["hrsh7th/cmp-buffer"] = {
      after = "cmp-nvim-lsp",
   },

   ["hrsh7th/cmp-nvim-lsp-signature-help"] = {
      after = "cmp-nvim-lsp",
   },

   ["hrsh7th/cmp-path"] = {
      after = "cmp-buffer",
   },

   -- misc plugins
   ["windwp/nvim-autopairs"] = {
      after = "nvim-cmp",
      config = function()
         require("custom.configs.others").autopairs()
      end,
   },

   ["goolord/alpha-nvim"] = {
      after = "base46",
      config = function()
         require "custom.configs.alpha"
      end,
   },

   ["numToStr/Comment.nvim"] = {
      module = "Comment",
      keys = { "gc", "gb" },
      config = function()
         require("custom.configs.others").comment()
      end,
   },

   -- file managing , picker etc
   ["kyazdani42/nvim-tree.lua"] = {
      ft = "alpha",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "custom.configs.nvimtree"
      end,
   },

   ["nvim-telescope/telescope.nvim"] = {
      cmd = "Telescope",
      config = function()
         require "custom.configs.telescope"
      end,
   },

  ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.configs.null-ls").setup()
      end,
  },
  ["tpope/vim-surround"] = {},
  ["editorconfig/editorconfig-vim"] = {},
  ["junegunn/gv.vim"] = {},
  ["prettier/vim-prettier"] = {},
  ["mg979/vim-visual-multi"] = {},

}

require("core.packer").run(plugins)
