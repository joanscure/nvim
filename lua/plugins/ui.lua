return {
  -- === Tema ===
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            info = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            info = { "underline" },
          },
        },
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        treesitter = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- === Barra de Estado ===
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "catppuccin", globalstatus = true },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- === UI de Pestañas (Bufferline) ===
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

  -- === Iconos ===
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- === Mejoras de UI (Inputs/Selects) ===
  { "stevearc/dressing.nvim", event = "VeryLazy", opts = {} },

  -- === Notificaciones ===
  { "rcarriga/nvim-notify", event = "VeryLazy", opts = {} },

  -- === NUEVO: Noice (UI Experimental y Cmdline) ===
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        -- Sobrescribe el manejo de docs/hover de LSP para usar Noice
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- Barra de búsqueda abajo (como VS Code)
        command_palette = true, -- Paleta de comandos centrada
        long_message_to_split = true, -- Mensajes largos a split
        inc_rename = false, -- Diálogo de renombrado (requiere plugin inc-rename)
        lsp_doc_border = false, -- Borde en docs
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- === Ayuda de Teclas ===
  { "folke/which-key.nvim", event = "VeryLazy", opts = {} },
}
