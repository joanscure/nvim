return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    { "<leader>qs", function() require("persistence").load() end, desc = "Restaurar Sesión" },
    { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restaurar Última Sesión" },
    { "<leader>qd", function() require("persistence").stop() end, desc = "No guardar sesión al salir" },
  },
}
