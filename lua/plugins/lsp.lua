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
  -- Catalogo de JSON Schemas para yamlls/jsonls (json/yaml.schemas()
  -- devuelven tablas estaticas embebidas, sin red en cada arranque)
  { "b0o/SchemaStore.nvim", lazy = true },
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
      -- "prepend" (no "append"): en esta maquina hay un
      -- vscode-css-language-server global instalado por npm en
      -- C:\nvm4w\nodejs que queda antes que mason/bin en el PATH del
      -- sistema y esta roto (falla el spawn); con "append" ese binario
      -- global siempre ganaba. "prepend" asegura que los binarios que
      -- instala/gestiona mason tengan prioridad sobre cualquier instalacion
      -- global equivalente.
      PATH = "prepend",
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
    dependencies = { "saghen/blink.cmp", "b0o/SchemaStore.nvim" },
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

      -- Resuelve la ruta de un paquete instalado por Mason (mismo patron
      -- que ya usa java.lua para respetar install_root_dir = "C:\mason").
      local mason_root = vim.fn.has("win32") == 1 and "C:\\mason" or (vim.fn.stdpath("data") .. "/mason")
      local function mason_pkg_path(pkg, suffix)
        return mason_root .. "/packages/" .. pkg .. (suffix or "")
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
        -- vtsls hace de host de intelligence para Angular: se le registra
        -- @angular/language-server (paquete ya instalado por mason via
        -- angularls) como plugin global de tsserver.
        vtsls = {
          settings = {
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = "@angular/language-server",
                    location = mason_pkg_path("angular-language-server", "/node_modules/@angular/language-server"),
                    enableForWorkspaceTypeScriptVersions = false,
                  },
                },
              },
            },
          },
        },
        -- angularls sigue corriendo para diagnosticos de plantilla, pero se
        -- le apaga renameProvider: vtsls (con el plugin de arriba) ya cubre
        -- el rename y sin esto salian dos dialogos de rename duplicados.
        angularls = {
          on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.renameProvider = false
          end,
        },
        html = {},
        cssls = {},
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
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
              -- El catalogo lo da SchemaStore.nvim (tabla estatica); se
              -- apaga el schema store propio de yamlls para no tener dos
              -- fuentes de catalogo pisandose entre si.
              schemaStore = { enable = false, url = "" },
              schemas = vim.tbl_extend("force", require("schemastore").yaml.schemas(), {
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
              }),
            },
          },
        },
      }

      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      for name, config in pairs(servers) do
        if next(config) ~= nil then
          vim.lsp.config(name, config)
        end
        vim.lsp.enable(name)
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
      formatters = {
        -- Resuelto a ruta completa (mismo patron de mason_root que lsp.lua
        -- y java.lua) para no depender del timing de PATH de mason.nvim.
        ["google-java-format"] = {
          command = (vim.fn.has("win32") == 1 and "C:\\mason" or (vim.fn.stdpath("data") .. "/mason"))
            .. "/bin/google-java-format"
            .. (vim.fn.has("win32") == 1 and ".cmd" or ""),
        },
      },
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
        -- google-java-format en vez del perfil Eclipse/JDT hecho a mano
        -- (jdtls sigue con format.enabled=false, ver java.lua). Es el
        -- formatter estandar de Java; a cambio de eso reescribe todo a su
        -- propio estilo y no respeta saltos de linea manuales.
        java = { "google-java-format" },
      },
      format_on_save = function(bufnr)
        -- Tanda 1: formatters deterministas ya probados. js/ts/html y java
        -- se agregan despues de confirmar manualmente con <leader>fm que
        -- el resultado es el esperado.
        local autoformat_fts = { "lua", "json", "yaml", "css", "python" }
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
    opts = {
      ensure_installed = {
        "prettierd",
        "prettier",
        "stylua",
        "black",
        "prisma-language-server",
        "java-debug-adapter",
        "java-test",
        "google-java-format",
        -- Linters (ver lint.lua)
        "ruff",
        "hadolint",
        "stylelint",
        "phpcs",
      },
    },
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
