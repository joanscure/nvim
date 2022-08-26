local M = {}

M.setup_lsp = function(attach, _capabilities)
   local _lspconfig = require "lspconfig"

   -- lspservers with default config
   local servers = { "html", "cssls", "clangd","emmet_ls", "stylelint_lsp", "intelephense" }

   for _, lsp in ipairs(servers) do
      _lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = _capabilities,
      }
   end
end


return M
