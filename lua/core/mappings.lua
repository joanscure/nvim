-- n, v, i, t = mode names

local function termcodes(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local M = {}


M.general = {
	i = {
		-- go to  beginning and end
		["<C-b>"] = { "<ESC>^i", "beginning of line" },
		["<C-e>"] = { "<End>", "end of line" },

		[";;"] = { "<end>;<End>" , opts = { noremap = true, silent = true}},
	},

	n = {
		["<ESC>"] = { "<cmd> noh <CR>", "no highlight" },

		-- switch between windows
		["<C-h>"] = { "<C-w>h", "window left" },
		["<C-l>"] = { "<C-w>l", "window right" },
		["<C-j>"] = { "<C-w>j", "window down" },
		["<C-k>"] = { "<C-w>k", "window up" },

		-- save
		["<C-s>"] = { "<cmd> w <CR>", "save file" },

		-- Copy all
		["<C-c>"] = { "<cmd> %y+ <CR>", "copy whole file" },

		-- line numbers
		["<leader>n"] = { "<cmd> set nu! <CR>", "toggle line number" },
		["<leader>rn"] = { "<cmd> set rnu! <CR>", "toggle relative number" },

		-- update nvchad
		["<leader>uu"] = { "<cmd> :NvChadUpdate <CR>", "update nvchad" },

		["<leader>tt"] = {
			function()
				require("base46").toggle_theme()
			end,
			"toggle theme",
		},

		-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
		-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
		-- empty mode is same as using <cmd> :map
		-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
		-- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		-- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },

		-- new buffer
		["<S-b>"] = { "<cmd> enew <CR>", "new buffer" },

		-- close buffer + hide terminal buffer
		["<leader>x"] = {
			function()
				require("core.utils").close_buffer()
			end,
			"close buffer",
		},
	},

	t = { ["<C-x>"] = { termcodes "<C-\\><C-N>", "escape terminal mode" } },

	v = {
		-- ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		-- ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', opts = { expr = true } },
		-- ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', opts = { expr = true } },
		-- Don't copy the replaced text after pasting in visual mode
		-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
		["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', opts = { silent = true } },
	},
}

M.comment = {
	plugin = true,

	-- toggle comment in both modes
	n = {
		["<leader>/"] = {
			function()
				require("Comment.api").toggle.linewise.current()
			end,
			"toggle comment",
		},
	},

	v = {
		["<leader>/"] = {
			"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
			"toggle comment",
		},
	},
}

M.lspconfig = {
	plugin = true,

	-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions

	n = {
		["gvd"] = {
			'<cmd> vsplit <CR> <ESC> <cmd> lua vim.lsp.buf.definition()<CR>',
			"lsp definition on window split",
		},

		["[g"] = {
			"<cmd> <Plug>(coc-diagnostic-prev)",
			"goto prev",
			opts = { silent = true }
		},

		["]g"] = {
			"<cmd> <Plug>(coc-diagnostic-next)",
			"goto next",
			opts = { silent = true }
		},
		["gd"] = {
			"<cmd> <Plug>(coc-definition)",
			"goto definition",
			opts = { silent = true }
		},

		["gy"] = {
			"<cmd> <Plug>(coc-type-definition)",
			"goto type definition",
			opts = { silent = true }
		},

		["gi"] = {
			"<cmd> <Plug>(coc-type-implementation)",
			"goto type implementation",
			opts = { silent = true }
		},

		["gr"] = {
			"<cmd> <Plug>(coc-references)",
			"goto reference",
			opts = { silent = true }
		},

		["K"] = {
			"<cmd> call ShowDocumentation()<CR>",
			"goto reference",
			opts = { silent = true, noremap = true}
		},

		["<leader>rn"] = {
			"<cmd> <Plug>(coc-rename)",
			"goto rename"
		},
		["<leader>ac"] = {
			"<cmd> <Plug>(coc-codeaction)",
			"goto code action"
		},

		["<leader>qf"] = {
			"<cmd> <Plug>(coc-fix-current)",
			"goto fix current"
		},

		["<leader>cl"] = {
			"<cmd> <Plug>(coc-codelens-action)",
			"goto codelens action"
		},
	},
}

M.nvimtree = {
	plugin = true,

	n = {
		-- toggle
		["<c-b>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },

		-- focus
		["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },
	},
}

M.nvterm = {
	plugin = true,

	t = {
		-- toggle in terminal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle "float"
			end,
			"toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle "horizontal"
			end,
			"toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle "vertical"
			end,
			"toggle vertical term",
		},
	},

	n = {
		-- toggle in normal mode
		["<A-i>"] = {
			function()
				require("nvterm.terminal").toggle "float"
			end,
			"   toggle floating term",
		},

		["<A-h>"] = {
			function()
				require("nvterm.terminal").toggle "horizontal"
			end,
			"   toggle horizontal term",
		},

		["<A-v>"] = {
			function()
				require("nvterm.terminal").toggle "vertical"
			end,
			"   toggle vertical term",
		},
	},
}

M.blankline = {
	plugin = true,

	n = {
		["<leader>bc"] = {
			function()
				local ok, start = require("indent_blankline.utils").get_current_context(
				vim.g.indent_blankline_context_patterns,
				vim.g.indent_blankline_use_treesitter_scope
				)

				if ok then
					vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
					vim.cmd [[normal! _]]
				end
			end,

			"Jump to current_context",
		},
	},
}


M.gv = {

	i = {
		["<A-j>"] = { ":m '<Esc>:m .+1<CR>==gi", opts = { noremap = true }},
		["<A-k>"] = { ":m '<Esc>:m .-2<CR>==gi", opts = { noremap = true } },
	},

	n = {
		["<A-j>"] = { ":m .+1<CR>==", opts = { noremap = true }},
		["<A-k>"] = { ":m .-2<CR>==", opts = { noremap = true } },
	},

	v = {
		["<"] = { "<gv", opts = { noremap = true }},
		[">"] = { ">gv", opts = { noremap = true }},
		["<A-j>"] = { ":m '>+1<CR>gv=gv", opts = { noremap = true }},
		["<A-k>"] = { ":m '<-2<CR>gv=gv", opts = { noremap = true } },
	}
}

M.gitgutter = {
	n = {
		["ghs"] = { "<Plug>(GitGutterStageHunk)"},
		["ghu"] = { "<Plug>(GitGutterUndoHunk)"},
		["ghp"] = { "<Plug>(GitGutterPreviewHunk)"},
	}

}

M.prettier = {
	n = {
		["<leader>p"] = { "<cmd> :Prettier<CR>", "Format prettier", opts = { noremap = true, silent = true}},
	},

}

M.fzf = {
	n = {
		["<c-p>"] = { ":FZF -i<CR>", "Fzf"},
		["<c-f>"] = { ":Rg<CR>", "Rg"},
	},

}


M.bufferline = {
	n = {
		["<TAB>"] = { "<cmd> :BufferLineCycleNext<CR>", "Tab Next", opts = { noremap = true, silent = true}},
		["<S-Tab>"] = { "<cmd> :BufferLineCyclePrev<CR>", "Tab previous", opts = { noremap = true, silent = true}},
	},


}

return M
