return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  {
    "williamboman/mason.nvim",
    -- Sin `event`, con `defaults.lazy = true` (lazy.lua) este plugin no
    -- tiene ningun disparador propio y nunca se carga solo por tener
    -- `cmd`: hay que darle un evento real para que su setup() (que agrega
    -- mason/bin al PATH) corra antes de que nvim-lspconfig intente
    -- spawnear servidores en BufReadPre. Verificado con
    -- `nvim --headless` + `lazy.core.config`: sin esto, mason.nvim queda
    -- `loaded=false` para siempre y el LSP falla con "failed to spawn"
    -- aunque el binario ya este instalado.
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    opts = {
      PATH = "append",
      -- En Windows, "C:\Users\<nombre con espacio>" rompe el quoting de
      -- cmd.exe al invocar los .cmd que instala Mason para servidores
      -- Node (angularls, eslint, etc.), sin importar el usuario. Se
      -- instala en una ruta fija sin espacios para evitarlo de raiz.
      install_root_dir = vim.fn.has("win32") == 1 and "C:\\mason" or nil,
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls", "vtsls", "angularls", "html", "cssls", "jsonls", "marksman",
        "prismals", "pyright", "eslint", "jdtls", "yamlls", "intelephense",
        "dockerls", "docker_compose_language_service",
      },
      -- jdtls lo arranca java.lua a mano (nvim-jdtls, con ruta de mason
      -- resuelta y soporte Lombok/debug bundles). Si mason-lspconfig lo
      -- auto-habilita tambien, lanza en paralelo su propio cliente con
      -- `cmd = "jdtls"` a secas (nvim-lspconfig/lsp/jdtls.lua), que falla
      -- al spawnear porque no resuelve la ruta de C:\mason\bin.
      automatic_enable = { exclude = { "jdtls" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      vim.diagnostic.config({
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
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

      -- docker_compose_language_service solo arranca en filetype
      -- "yaml.docker-compose"; Neovim detecta estos archivos como "yaml"
      -- a secas por defecto.
      vim.filetype.add({
        pattern = {
          [".*docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
          [".*compose%.ya?ml"] = "yaml.docker-compose",
        },
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(m, lhs, rhs, desc)
          vim.keymap.set(m, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Definición")
        map("n", "gr", vim.lsp.buf.references, "Referencias")
        map("n", "gi", vim.lsp.buf.implementation, "Implementaciones")
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
        map("n", "<leader>ca", function()
          local ok, fzf = pcall(require, "fzf-lua")
          if ok then
            fzf.lsp_code_actions()
          else
            vim.lsp.buf.code_action()
          end
        end, "Code Action")
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
        angularls = {},
        html = {},
        cssls = {},
        jsonls = {},
        marksman = {},
        prismals = {},
        pyright = {},
        eslint = {},
        intelephense = {},
        dockerls = {},
        docker_compose_language_service = {},
        yamlls = {
          settings = {
            yaml = {
              validate = true,
              hover = true,
              completion = true,
              schemaStore = { enable = true, url = "https://www.schemastore.org/api/json/catalog.json" },
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
                ["https://json.schemastore.org/pre-commit-config.json"] = ".pre-commit-config.yaml",
              },
            },
          },
        },
      }

      local use_new_api = vim.fn.has("nvim-0.11") == 1

      if use_new_api then
        vim.lsp.config('*', {
          capabilities = capabilities,
          on_attach = on_attach,
        })
        for name, config in pairs(servers) do
          if next(config) ~= nil then
            vim.lsp.config(name, config)
          end
          vim.lsp.enable(name)
        end
      else
        local lspconfig = require("lspconfig")
        for name, config in pairs(servers) do
          lspconfig[name].setup(vim.tbl_deep_extend("force", config, {
            capabilities = capabilities,
            on_attach = on_attach,
          }))
        end
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>ci", "<cmd>ConformInfo<cr>", desc = "Info de Formateo" },
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Formatear (Conform)",
      },
    },
    opts = {
      notify_on_error = true,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        python = { "black" },
        -- java: sin entrada aca a proposito. Lo formatea jdtls via LSP
        -- (ver java.lua, java-formatter.xml) en vez de google-java-format,
        -- que ignoraba los saltos de linea manuales del usuario.
      },
      format_on_save = function(bufnr)
        -- Solo auto-formatear estos lenguajes al guardar
        -- java: DESACTIVADO. El format via jdtls (join_wrapped_lines=false)
        -- estaba borrando codigo al guardar en vez de formatear bien.
        -- Pendiente investigar antes de reactivar.
        local autoformat_fts = { "lua" }
        local ft = vim.bo[bufnr].filetype
        if vim.tbl_contains(autoformat_fts, ft) then
          return { timeout_ms = 3000, lsp_format = "fallback" }
        end
        return false
      end,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync", "MasonToolsUpdate", "MasonToolsUpdateSync" },
    opts = { ensure_installed = { "prettierd", "prettier", "stylua", "black", "prisma-language-server", "java-debug-adapter", "java-test" } },
  },

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      progress = {
        ignore = {
          -- jdtls revalida el archivo en cada cambio y manda progress
          -- reports tipo "Validate documents" / "Publish Diagnostics"
          -- todo el tiempo; es ruido, no aporta nada util a diferencia
          -- del progreso real de indexado/import al abrir el proyecto.
          function(msg)
            if not (msg.lsp_client and msg.lsp_client.name == "jdtls") then
              return false
            end
            local text = ((msg.title or "") .. " " .. (msg.message or "")):lower()
            return text:find("validat", 1, true) ~= nil
              or text:find("publish", 1, true) ~= nil
              or text:find("diagnostic", 1, true) ~= nil
          end,
        },
      },
    },
  },
}
