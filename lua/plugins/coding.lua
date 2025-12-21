local function has_c_compiler()
  for _, c in ipairs({ "clang", "cl", "zig", "gcc", "cc" }) do
    if vim.fn.executable(c) == 1 then return true end
  end
  return false
end

return {
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "none",
        ["<C-k>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-g>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true },
    },
    opts_extend = { "sources.default" },
  },

  { "windwp/nvim-ts-autotag", cond = has_c_compiler, event = "InsertEnter", opts = {} },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      pre_hook = function(ctx)
        local U = require("Comment.utils")
        local type = ctx.ctype == U.ctype.line and "__default" or "__multiline"
        local ok, ts_integration = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if not ok then return end
        return ts_integration.create_pre_hook()(ctx)
      end,
    },
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    cond = has_c_compiler,
    event = "VeryLazy",
    opts = { enable_autocmd = false },
  },

  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "sa", delete = "ds", replace = "cs",
        find = "", find_left = "", highlight = "",
        update_n_lines = "", suffix_last = "", suffix_next = "",
      },
    },
  },

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }, {}),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
      }
    end,
  },
}
