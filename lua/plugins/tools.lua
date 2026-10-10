return {
  -- Auto-close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- use treesitter to check for pairs
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        typescript = { "template_string" },
      },
      fast_wrap = {
        map = "<M-e>", -- Alt+e to wrap
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        before_key = "h",
        after_key = "l",
        cursor_pos_before = true,
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      -- integrate with blink.cmp if available
      local ok, blink = pcall(require, "blink.cmp")
      -- autopairs works automatically, no extra integration needed for blink
    end,
  },

  -- Show colors inline (HEX, RGB, etc.)
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      "*", -- all filetypes
      css = { rgb_fn = true },
      html = { names = false },
    },
    config = function(_, opts)
      require("colorizer").setup(opts)
    end,
  },

  -- Terminal management
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal (Float)" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Terminal (Horizontal)" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Terminal (Vertical)" },
    },
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    },
  },

  -- Search and replace across files (grug-far: funciona en Windows, sin dependencia de sed)
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>sr", function() require("grug-far").open() end,                                                          desc = "Buscar y Reemplazar (global)" },
      { "<leader>sw", function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,      desc = "Buscar palabra bajo cursor" },
      { "<leader>sr", function() require("grug-far").open() end, mode = "v",                                              desc = "Buscar selección" },
      { "<leader>sp", function() require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } }) end,             desc = "Buscar en archivo actual" },
    },
    opts = {
      keymaps = {
        replace          = { n = "<M-r>" },  -- Alt+R : reemplazar todos los resultados visibles
        qflist           = { n = "<M-q>" },  -- Alt+Q : enviar resultados a quickfix
        abort            = { n = "<M-a>" },  -- Alt+A : cancelar operación en curso
        refresh          = { n = "<M-f>" },  -- Alt+F : refrescar resultados
        openLocation     = { n = "<M-o>" },  -- Alt+O : abrir archivo en la ubicación
        gotoLocation     = { n = "<CR>" },   -- Enter : ir al resultado bajo el cursor
        openNextLocation = { n = "<C-j>" },  -- Ctrl+J: siguiente resultado (y abrirlo)
        openPrevLocation = { n = "<C-k>" },  -- Ctrl+K: resultado anterior (y abrirlo)
        help             = { n = "g?" },     -- g?    : mostrar todos los atajos
      },
    },
  },
}
