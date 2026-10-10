return {
  -- Magit-style git UI: status, stage, commit, push/pull, log (reemplaza lazygit)
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit (status)" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Git pull" },
      { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Git push" },
      { "<leader>gL", "<cmd>Neogit log<cr>", desc = "Git log" },
    },
    opts = {
      integrations = { diffview = true },
    },
  },

  -- Diffs por commit y file-history navegable
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview (cambios pendientes)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Historial de este archivo" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Historial del repo" },
    },
    opts = {},
  },
}
