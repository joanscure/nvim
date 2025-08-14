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
    cmd = "FzfLua",
    keys = {
      { "<C-p>",      function() require("fzf-lua").files() end,            mode = "n", desc = "Buscar archivos" },
      { "<C-f>",      function() require("fzf-lua").live_grep_native() end, mode = "n", desc = "Buscar texto" },
      { "<leader>fb", function() require("fzf-lua").buffers() end,          mode = "n", desc = "Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end,        mode = "n", desc = "Help" },
    },
    opts = {
      files = {
        cmd = table.concat({
          "fd", "--type", "f", "--hidden",
          "--exclude", ".git",
          "--exclude", "node_modules",
          "--exclude", "dist",
          "--exclude", "build",
          "--exclude", ".next",
          "--exclude", "coverage",
          "--exclude", ".cache",
        }, " "),
      },
      grep = {
        rg_opts = table.concat({
          "--hidden",
          "--column",
          "--line-number",
          "--no-heading",
          "--smart-case",
          "--max-columns=4096",
          "-g", "!.git",
          "-g", "!node_modules",
          "-g", "!dist",
          "-g", "!build",
          "-g", "!.next",
          "-g", "!coverage",
          "-g", "!.cache",
        }, " "),
      },
    },
  },
  -- === Git ===
  { "tpope/vim-fugitive", cmd = { "G", "Git", "Gvdiff" } },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame = false,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc, extra)
          local o = { buffer = bufnr, silent = true, desc = "Git: " .. desc }
          if extra then for k,v in pairs(extra) do o[k]=v end end
          vim.keymap.set(mode, lhs, rhs, o)
        end

        -- Navegación entre cambios (igual que GitGutter)
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(gs.next_hunk); return '<Ignore>'
        end, 'Siguiente cambio', { expr = true })
        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(gs.prev_hunk); return '<Ignore>'
        end, 'Cambio anterior', { expr = true })

        -- Alternativo por si recuerdas ]g / [g
        map('n', ']g', gs.next_hunk, 'Siguiente cambio (alt)')
        map('n', '[g', gs.prev_hunk, 'Cambio anterior (alt)')

        -- Acciones sobre el hunk actual
        map({'n','v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
        map({'n','v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Revertir hunk (dejar como antes)')
        map('n',        '<leader>hS', gs.stage_buffer,               'Stage buffer entero')
        map('n',        '<leader>hR', gs.reset_buffer,               'Reset buffer entero')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo stage hunk')

        -- Extras útiles
        map('n', '<leader>hb', function() gs.blame_line{ full = true } end, 'Blame (línea)')
        map('n', '<leader>hd', gs.diffthis, 'Diff contra index')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff contra último commit')
        map('n', '<leader>td', gs.toggle_deleted, 'Mostrar líneas borradas')

        -- (Opcional) atajos “tipo memoria muscular”:
        map('n', 'ghu', gs.reset_hunk,   'Revertir hunk (ghu)')
        map('n', 'ghp', gs.preview_hunk, 'Preview hunk (ghp)')
        -- Si de verdad quieres 'hgu'/'hgp' SIN prefijo (no recomendado porque pisa la tecla 'h'):
        -- vim.keymap.set('n','hgu', gs.reset_hunk,   { buffer=bufnr, silent=true, desc='Git: Revertir hunk' })
        -- vim.keymap.set('n','hgp', gs.preview_hunk, { buffer=bufnr, silent=true, desc='Git: Preview hunk' })
      end,
    },
  },

  -- === LSP + Autocompletado ===
  { "folke/neodev.nvim", ft = "lua", opts = {} },
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    opts = { PATH = "append" },
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
        map("n", "<A-f>", function() require("conform").format({ async = true, lsp_fallback = true }) end, "Formatear")
      end

      -- Servidores
      -- Lua
      lsp.lua_ls.setup({
        capabilities = cmp_caps,
        on_attach = on_attach,
        settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { checkThirdParty = false } } },
      })

      if lsp.vtsls then
        lsp.vtsls.setup({ capabilities = cmp_caps, on_attach = on_attach })
      else
        lsp.ts_ls.setup({ capabilities = cmp_caps, on_attach = on_attach })
      end

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
  -- lo que ya tienes...
  lua = { "stylua" },
  -- añade prisma si lo usas
  prisma = { "prismaFmt" },
  -- JS/TS/… ya están con prettierd/prettier
},

-- Fuerza comandos robustos (Windows)
formatters = {
  -- Usa el .exe real de Stylua para evitar el problema del espacio en la ruta
  stylua = function()
    local util = require("conform.util")
    local mason = vim.fn.stdpath("data")
    local exe = mason .. "/mason/packages/stylua/stylua/bin/stylua"
    if vim.loop.os_uname().sysname == "Windows_NT" then
      exe = exe .. ".exe"
    end
    return {
      command = util.find_executable({ exe }, "stylua"),
      args = { "--search-parent-directories", "--stdin-filepath", "$FILENAME", "-" },
      stdin = true,
    }
  end,

  -- Prisma: formatea al archivo (no por stdin)
  prismaFmt = {
    command = "prisma",
    args = { "format", "--schema", "$FILENAME" },
    stdin = false,
  },
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
      add = "sa",        -- antes: sa
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
  -- { "RRethy/vim-illuminate", event = "VeryLazy", opts = {} },
}
