return {
  -- === LSP Config ===
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
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      local cmp_caps = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Definición")
        map("n", "gr", vim.lsp.buf.references, "Referencias")
        map("n", "gi", vim.lsp.buf.implementation, "Implementaciones")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diag")
        map("n", "]d", vim.diagnostic.goto_next, "Next diag")
        map("n", "<A-f>", function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, "Formatear")
      end

      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
        vtsls = {},
        html = {},
        cssls = {},
        jsonls = {},
        marksman = {},
        prismals = {},
        pyright = {},
        eslint = {},
      }

      local use_new_api = vim.fn.has("nvim-0.11") == 1

      if use_new_api then
        for name, config in pairs(servers) do
          vim.lsp.config[name] = vim.tbl_deep_extend("force", config, {
            capabilities = cmp_caps,
            on_attach = on_attach,
          })
          vim.lsp.enable(name)
        end
      else
        local lspconfig = require("lspconfig")
        for name, config in pairs(servers) do
          lspconfig[name].setup(vim.tbl_deep_extend("force", config, {
            capabilities = cmp_caps,
            on_attach = on_attach,
          }))
        end
      end
    end,
  },

  -- === Formateo (Conform) ===
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>ci", "<cmd>ConformInfo<cr>", desc = "Info de Formateo" },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        prisma = { "prismaFmt" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
      format_on_save = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = { ensure_installed = { "prettierd", "prettier", "stylua", "eslint_d", "black", "prisma-language-server" } },
  },

  -- === Notificaciones de Progreso LSP ===
  { "j-hui/fidget.nvim", event = "LspAttach", opts = {} },
}
