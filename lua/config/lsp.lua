
local on_attach = function(client, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  -- Navegación y acciones básicas
  bufmap("n", "gd", vim.lsp.buf.definition)
  bufmap("n", "gvd", function()
    vim.cmd("vsplit")
    vim.lsp.buf.definition()
  end)
  bufmap("n", "gf", vim.lsp.buf.type_definition)
  bufmap("n", "gi", vim.lsp.buf.implementation)
  bufmap("n", "gr", vim.lsp.buf.references)

  -- Documentación
  bufmap("n", "K", vim.lsp.buf.hover)

  -- Acciones y refactor
  bufmap("n", "<leader>a", vim.lsp.buf.code_action)
  bufmap("x", "<leader>a", vim.lsp.buf.code_action)
  bufmap("n", "<leader>rn", vim.lsp.buf.rename)

  -- Diagnósticos
  bufmap("n", "[g", vim.diagnostic.goto_prev)
  bufmap("n", "]g", vim.diagnostic.goto_next)

  -- Formateo
  bufmap("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end)
end

-- Exportar para usarlo en lazy.nvim
return {
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities()
}
