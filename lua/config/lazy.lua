-- Asegúrate de que lazy.nvim esté instalado
local install_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(install_path) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--single-branch', '--depth=1',
    'https://github.com/folke/lazy.nvim.git', install_path
  })
end
vim.opt.runtimepath:prepend(install_path)

-- Configura los plugins usando lazy.nvim
require('lazy').setup({
  -- IDE y herramientas
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls",
          "ts_ls",
          "pyright",
          "prismals",
          "marksman",
          "html",
          "cssls",
          "jsonls",
          "eslint", }, -- ajusta según tu stack
      })

      local lsp = require("lspconfig")
      local lsp_conf = require("config.lsp")

      local servers = {
        "ts_ls",
        "prismals",
        "marksman",
        "html",
        "cssls",
        "jsonls",
        "eslint",
        "lua_ls",
        "pyright",
      }

      for _, server in ipairs(servers) do
        if server == "emmet_ls" then
          lsp[server].setup({
            on_attach = lsp_conf.on_attach,
            capabilities = lsp_conf.capabilities,
            filetypes = {
              "html", "css", "scss", "javascriptreact", "typescriptreact", "vue",
            },
          })

        else
          lsp[server].setup({
            on_attach = lsp_conf.on_attach,
            capabilities = lsp_conf.capabilities,
          })
        end
      end

      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "css", "html", "json", "yaml", "markdown" },
          }),
        },
      })

      -- Atajo para formatear
      vim.keymap.set("n", "<a-f>", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format code" })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup()
    end
  }

  -- =========================
  -- 🪶 mini.nvim módulos
  -- =========================
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.surround").setup()
      require("mini.comment").setup({
        hooks = {
          pre = function()
            require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
          end,
        },
      })
      require("mini.pairs").setup() -- opcional
    end
  },
  -- Otros plugins útiles
  'christoomey/vim-tmux-navigator',
  'junegunn/gv.vim',
  -- 'Exafunction/codeium.vim',
  'ayu-theme/ayu-vim',

  -- Plugins de Git
  'airblade/vim-gitgutter',
  'tpope/vim-fugitive',

  -- Plugins FZF

  {
    "ibhagwan/fzf-lua",
    config = function()
      require("fzf-lua").setup({
        files = { cmd = "fd --type f --hidden --exclude .git" }
      })
    end
  },
  -- =========================
  -- 🌳 Treesitter + commentstring
  -- =========================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  },

  -- =========================
  -- 📜 Undo persistente (opcional)
  -- =========================
  { "mbbill/undotree" },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup({})
    end
  },

  'stevearc/vim-vscode-snippets',
  -- Nvim Tree
  {
    'navarasu/onedark.nvim',
    config = function()
      require('onedark').setup {
        style = 'darker'
      }
      require('onedark').load()
    end
  },
  'nvim-tree/nvim-web-devicons',
  {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup {
        sync_root_with_cwd = false,
        filters = {
          dotfiles = false,
          git_clean = false,
          no_buffer = false,
          custom = { 'node_modules', 'dist', '.git', '.yarn', '.vscode', '.bundle' },
        },
        auto_reload_on_write = false,
        view = {
          adaptive_size = false,
          side = "right",
          width = 30,
          preserve_window_proportions = true,
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 5000,
        },
        diagnostics = {
          enable = false,
        },
        hijack_directories = {
          enable = false,
          auto_open = false,
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        filesystem_watchers = {
          enable = true,
        },
        actions = {
          use_system_clipboard = true,
          change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
          },
          expand_all = {
            max_folder_discovery = 300,
            exclude = {},
          },
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "shadow",
              style = "minimal",
            },
          },
          open_file = {
            quit_on_open = true,
            resize_window = true,
            window_picker = {
              enable = true,
              chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
              exclude = {
                filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                buftype = { "nofile", "terminal", "help" },
              },
            },
          },
          remove_file = {
            close_window = true,
          },
        },
      }
    end
  },

  -- Plugins de UI
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'ayu_dark',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = { 'NvimTree' },
          always_divide_middle = true,
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      }
    end
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons', -- Asegúrate de que los íconos estén instalados
    config = function()
      -- Configuración de bufferline
      require('bufferline').setup({})
    end
  },

  -- Otros plugins
  'mg979/vim-visual-multi',
  {
    "editorconfig/editorconfig-vim",
    lazy = false,
  }
})
