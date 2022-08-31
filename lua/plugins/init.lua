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
		-- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
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

	['pangloss/vim-javascript'] = {},
	['leafgarland/typescript-vim'] = {},
	['peitalin/vim-jsx-typescript'] = {},
	['styled-components/vim-styled-components'] = { 
		branch =  'main' 
	},

	['jparise/vim-graphql'] = {} ,
	['nvim-treesitter/nvim-treesitter'] = {
		cmd = require("core.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
	},

	['nvim-treesitter/nvim-treesitter-textobjects'] = {
		after = "nvim-treesitter"
	},

	['neoclide/coc.nvim'] = {
		branch = 'release',
		config = function()
			require("plugins.configs.coc")
		end
	}
}


require("core.packer").run(plugins)
