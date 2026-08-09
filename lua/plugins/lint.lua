-- Linting real (mas alla de lo que cada LSP reporta) via nvim-lint.
-- Solo lee el buffer, no lo muta -> no compite con conform.nvim.
-- js/ts no llevan linter aca a proposito: el server "eslint" (lsp.lua) ya
-- da esos mismos diagnosticos + EslintFixAll; duplicarlo aca solo genera
-- ruido repetido.
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        dockerfile = { "hadolint" },
        css = { "stylelint" },
        php = { "phpcs" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
