return {
  {
    "Bekaboo/dropbar.nvim",
    event = "VeryLazy",
    cond = function()
      return vim.fn.has("nvim-0.10") == 1
    end,
    opts = {
      bar = {
        enable = function(buf, win, _)
          return not vim.api.nvim_win_get_config(win).zindex
            and vim.bo[buf].buftype == ""
            and vim.api.nvim_buf_get_name(buf) ~= ""
            and not vim.wo[win].diff
        end,
      }
    }
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Abrir todos los pliegues" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Cerrar todos los pliegues" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Abrir pliegues (menos algunos)" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Cerrar pliegues (nivel)" },
      { "zp", function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Previsualizar pliegue" },
    },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
  },
}
