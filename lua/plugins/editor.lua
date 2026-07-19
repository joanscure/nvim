return {
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
        filtered_items = {
          visible = true, 
          hide_dotfiles = false,
          hide_gitignored = true, 
          never_show = { 
            ".git",
            ".ds_store",
            "node_modules",
          },
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, 
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },

  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<C-p>",      function() require("fzf-lua").files() end,            mode = "n", desc = "Buscar archivos" },
      { "<C-f>",      function() require("fzf-lua").live_grep() end,        mode = "n", desc = "Buscar texto" },
      { "<leader>fb", function() require("fzf-lua").buffers() end,          mode = "n", desc = "Buffers" },
      { "<leader>fh", function() require("fzf-lua").help_tags() end,        mode = "n", desc = "Help" },
      { "<leader>fg", function() require("fzf-lua").git_files() end,        mode = "n", desc = "Archivos git" },
      { "<leader>fr", function() require("fzf-lua").resume() end,           mode = "n", desc = "Retomar búsqueda" },
      { "<leader>ft", "<cmd>TodoFzfLua<cr>",                                mode = "n", desc = "TODOs del proyecto" },
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


  { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
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

  { "folke/todo-comments.nvim", event = "VeryLazy", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  { "mg979/vim-visual-multi", branch = "master", event = "VeryLazy" },
}
