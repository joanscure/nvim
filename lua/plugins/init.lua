vim.cmd "packadd packer.nvim"

local plugins = {

	["nvim-lua/plenary.nvim"] = { module = "plenary" },

	["kyazdani42/nvim-web-devicons"] = {
		module = "nvim-web-devicons",
		config = function()
			require("plugins.configs.others").devicons()
		end,
	},

	["wbthomason/packer.nvim"] = {
		cmd = require("core.lazy_load").packer_cmds,
		config = function()
			require "plugins"
		end,
	},

	["numToStr/Comment.nvim"] = {
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require("plugins.configs.others").comment()
		end,
		setup = function()
			require("core.utils").load_mappings "comment"
		end,
	},

	-- file managing , picker etc
	["kyazdani42/nvim-tree.lua"] = {
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			require "plugins.configs.nvimtree"
		end,
		setup = function()
			require("core.utils").load_mappings "nvimtree"
		end,
	},
	-- Speed up deffered plugins
	["lewis6991/impatient.nvim"] = {},

	["tpope/vim-surround"] = {},
	["editorconfig/editorconfig-vim"] = {},
	["junegunn/gv.vim"] = {},
	["prettier/vim-prettier"] = {},
	["mg979/vim-visual-multi"] = {},

	["airblade/vim-gitgutter"] = {},
	["tpope/vim-fugitive"] = {},
	["tpope/vim-surround"] = {},

	["nvim-lualine/lualine.nvim"] = {
		after = "nvim-web-devicons",
		config = function()
			require("plugins.configs.lualine")
		end
	},

	["akinsho/bufferline.nvim"] = {
		tag = "v2.*",
		after = "nvim-web-devicons",
		config = function()
			require("plugins.configs.bufferline")
		end
	},

	["Mofiqul/vscode.nvim"] = {
		config = function()
			require("plugins.configs.colors")
		end,
	},
	["junegunn/fzf"] = {
		run = ":call fzf#install()",
		config = function()
			require("plugins.configs.fzf")
		end,
	},
	["junegunn/fzf.vim"] = {},
	["neovim/nvim-lspconfig"] = {
		opt = true,
		cmd = require("core.lazy_load").lsp_cmds,
		setup = function()
			require("core.lazy_load").on_file_open "nvim-lspconfig"
		end,
		config = function()
			require "plugins.configs.lspconfig"
		end,
	},
	["L3MON4D3/LuaSnip"] = {
	after = "nvim-lspconfig",
  -- config = function()
  --     require("plugins.configs.others").luasnip()
  --   end,

	},

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },

	["hrsh7th/cmp-nvim-lua"] = {
		after = "LuaSnip",
	},

	["hrsh7th/cmp-nvim-lsp"] = {
		after = "LuaSnip",
	},

	["hrsh7th/cmp-buffer"] = {
		after = "cmp-nvim-lsp",
	},

	["hrsh7th/cmp-path"] = {
		after = "cmp-buffer",
	},
	['hrsh7th/cmp-cmdline'] = {
		after = "cmp-path"
	},
	['hrsh7th/nvim-cmp'] = {
		after = "cmp-nvim-lsp",
		config = function()
			require "plugins.configs.cmp"
		end,
	}

}

require("core.packer").run(plugins)
