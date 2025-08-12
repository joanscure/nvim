-- Helper: carga Treesitter sólo si hay compilador disponible
local function has_c_compiler()
  for _, c in ipairs({ "clang", "cl", "zig", "gcc", "cc" }) do
    if vim.fn.executable(c) == 1 then return true end
  end
  return false
end

return {
  -- === Temas / UI ===
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "darker" },
    config = function(_, opts)
      local onedark = require("onedark")
      onedark.setup(opts)
      onedark.load()
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "onedark", globalstatus = true },
      sections = {
        lualine_a = { "mode" }, lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" }, lualine_z = { "location" },
      },
    },
  },
  { "rcarriga/nvim-notify", event = "VeryLazy", opts = {} },
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  -- Bufferline (UI de pestañas/buffers)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "slant",
        show_buffer_close_icons = false,
        always_show_bufferline = true,
        offsets = { { filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true } },
      },
    },
  },

  -- === Navegación ===
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    opts = {
      view = { side = "right", width = 30 },
      filters = { custom = { "node_modules", "dist", ".git", ".yarn", ".vscode", ".bundle" } },
      actions = { open_file = { quit_on_open = true } },
      update_focused_file = { enable = true },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = { "<C-p>", "<C-f>", { "<leader>fb", mode = "n" } },
    opts = { files = { cmd = "fd --type f --hidden --exclude .git" } },
  },

  -- === Git ===
  { "tpope/vim-fugitive", cmd = { "G", "Git", "Gvdiff" } },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = { current_line_blame = false },
  },

  -- === LSP + Autocompletado ===
  { "folke/neodev.nvim", ft = "lua", opts = {} },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    opts = { PATH = "append" }, -- añade ~/.local/share/nvim/mason/bin al PATH
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = { ensure_installed = { "lua_ls", "vtsls", "html", "cssls", "jsonls", "marksman", "prismals", "pyright", "eslint" } },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp", "folke/neodev.nvim" },
    config = function()
      local lsp = require("lspconfig")
      local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(m, lhs, rhs, desc) vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc }) end
        map("n", "gd", vim.lsp.buf.definition, "Definición")
        map("n", "gr", vim.lsp.buf.references, "Referencias")
        map("n", "gi", vim.lsp.buf.implementation, "Implementaciones")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diag")
        map("n", "]d", vim.diagnostic.goto_next, "Next diag")
        -- Formateo con Conform
        map("n", "<A-f>", function() require("conform").format({ async = true, lsp_fallback = true }) end, "Formatear")
      end

      -- Servidores
      -- Lua
      lsp.lua_ls.setup({
        capabilities = cmp_caps,
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
      })

      -- TypeScript/JS (vtsls es muy rápido)
      if lsp.vtsls then
        lsp.vtsls.setup({ capabilities = cmp_caps, on_attach = on_attach })
      else
        lsp.ts_ls.setup({ capabilities = cmp_caps, on_attach = on_attach })
      end

      -- Otros
      for _, server in ipairs({ "html", "cssls", "jsonls", "marksman", "prismals", "pyright", "eslint" }) do
        if lsp[server] then lsp[server].setup({ capabilities = cmp_caps, on_attach = on_attach }) end
      end
    end,
  },
  -- CMP + snippets
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

  -- Formateo (más simple y rápido que none-ls para formatear)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        lua = { "stylua" },
        python = { "black" },
        prisma = { "prismaFmt" },
      },
      format_on_save = false
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = { ensure_installed = { "prettierd", "prettier", "stylua", "eslint_d", "black", "prisma-language-server" } },
  },

  -- Treesitter + comentarios contextuales + autotag
  {
    "nvim-treesitter/nvim-treesitter",
    cond = has_c_compiler,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", cond = has_c_compiler } },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "json", "css", "html", "markdown", "markdown_inline", "python", "prisma" },
      incremental_selection = { enable = true },
      textobjects = { select = { enable = true } },
          },
    config = function(_, opts)
      local install = require("nvim-treesitter.install")
      install.compilers = { "zig", "clang", "cl", "gcc", "cc" }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  { "windwp/nvim-ts-autotag", cond = has_c_compiler, event = "InsertEnter", opts = {} },
  { -- Comentarios con soporte TS
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
  { "echasnovski/mini.surround", version = false, event = "VeryLazy", opts = {
    mappings = {
      add = "ys",        -- antes: sa
      delete = "ds",     -- antes: sd
      replace = "cs",    -- antes: sr
      find = "", find_left = "", highlight = "",
      update_n_lines = "", suffix_last = "", suffix_next = "",
    },
  }, },

  -- Quality of life
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
  { "folke/todo-comments.nvim", event = "VeryLazy", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
  { -- Carga nvim-ts-context-commentstring sólo si hay compilador
    "JoosepAlviste/nvim-ts-context-commentstring",
    cond = has_c_compiler,
    event = "VeryLazy",
    opts = { enable_autocmd = false },
  },

  -- Tmux
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  -- Multicursor (visual-multi clásico)
  { "mg979/vim-visual-multi", branch = "master", event = "VeryLazy" },
}
