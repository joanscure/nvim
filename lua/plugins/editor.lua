return {
  -- === Explorador de Archivos (Neo-tree) ===
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorador (NeoTree)",
      },
    },
    opts = {
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },

  -- === Buscador (Fzf) ===
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<C-p>",      function() require("fzf-lua").files() end,            mode = "n", desc = "Buscar archivos" },
      { "<C-f>",      function() require("fzf-lua").live_grep() end,        mode = "n", desc = "Buscar texto" },
      { "<leader>fb", function() require("fzf-lua").buffers() end,          mode = "n", desc = "Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end,        mode = "n", desc = "Help" },
    },
    opts = {
      files = {
        cmd = table.concat({
          "fd", "--type", "f", "--hidden",
          "--exclude", ".git", "--exclude", "node_modules",
          "--exclude", "dist", "--exclude", "build",
          "--exclude", ".next", "--exclude", "coverage", "--exclude", ".cache",
        }, " "),
      },
      grep = {
        rg_opts = table.concat({
          "--hidden", "--column", "--line-number", "--no-heading",
          "--smart-case", "--max-columns=4096",
          "-g", "!.git", "-g", "!node_modules",
          "-g", "!dist", "-g", "!build", "-g", "!.next",
          "-g", "!coverage", "-g", "!.cache",
        }, " "),
      },
    },
  },

  -- === Flash (Navegación Rápida) ===
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- === Trouble (Lista de Diagnósticos) ===
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
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

        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(gs.next_hunk); return '<Ignore>'
        end, 'Siguiente cambio', { expr = true })
        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(gs.prev_hunk); return '<Ignore>'
        end, 'Cambio anterior', { expr = true })

        map({'n','v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage hunk')
        map({'n','v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Revertir hunk')
        map('n',        '<leader>hS', gs.stage_buffer,               'Stage buffer')
        map('n',        '<leader>hR', gs.reset_buffer,               'Reset buffer')
        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', function() gs.blame_line{ full = true } end, 'Blame (línea)')
        map('n', '<leader>hd', gs.diffthis, 'Diff index')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff commit')
        map('n', '<leader>td', gs.toggle_deleted, 'Mostrar borrados')
      end,
    },
  },

  -- === Comentarios TODO ===
  { "folke/todo-comments.nvim", event = "VeryLazy", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

  -- === Tmux ===
  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },

  -- === Multicursor ===
  { "mg979/vim-visual-multi", branch = "master", event = "VeryLazy" },
}