local function has_c_compiler()
  for _, c in ipairs({ "clang", "cl", "zig", "gcc", "cc" }) do
    if vim.fn.executable(c) == 1 then return true end
  end
  return false
end

return {
  -- === Autocompletado (CMP) ===
  { "L3MON4D3/LuaSnip", event = "InsertEnter", dependencies = { "rafamadriz/friendly-snippets" }, config = function() require("luasnip.loaders.from_vscode").lazy_load() end },
  { "saadparwaiz1/cmp_luasnip", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-path", lazy = true },
  { "hrsh7th/cmp-buffer", lazy = true },
  { "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        },
      })
    end,
  },

  -- === Autocierre de Etiquetas ===
  { "windwp/nvim-ts-autotag", cond = has_c_compiler, event = "InsertEnter", opts = {} },

  -- === Comentarios Inteligentes ===
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

  -- === Surround (Rodear texto con " ' ( [ { ) ===
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "sa",        -- Agregar
        delete = "ds",     -- Borrar
        replace = "cs",    -- Cambiar
        find = "", find_left = "", highlight = "",
        update_n_lines = "", suffix_last = "", suffix_next = "",
      },
    },
  },

  -- === NUEVO: Mini.ai (Mejores objetos de texto) ===
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
