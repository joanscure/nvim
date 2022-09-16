vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)
require "core.init"

require "core.options"

-- setup packer + plugins
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
  print "Cloning packer .."
  fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path }

  -- install plugins + compile their configs
  vim.cmd "packadd packer.nvim"
  require "plugins"
  vim.cmd "PackerSync"
end

pcall(require, "custom")
require("core.utils").load_mappings()

-- coc 
vim.cmd [[ autocmd CursorHold * silent call CocActionAsync('highlight') ]]

vim.cmd[[
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
]]

-- Add `:Format` command to format current buffer.
vim.cmd[[ command! -nargs=0 Format :call CocActionAsync('format') ]]


--Add `:Fold` command to fold current buffer.
vim.cmd[[ command! -nargs=? Fold :call     CocAction('fold', <f-args>) ]]

-- Add `:OR` command for organize imports of the current buffer.
vim.cmd [[ command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport') ]]

-- Add (Neo)Vim's native statusline support.
vim.cmd [[ set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')} ]]

vim.cmd [[
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
]]
