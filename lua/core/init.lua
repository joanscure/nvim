-- autocmds
local autocmd = vim.api.nvim_create_autocmd
local api = vim.api

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- wrap the PackerSync command to warn people before using it in Neovim updated
autocmd("VimEnter", {
  callback = function()
    vim.cmd "command! -nargs=* -complete=customlist,v:lua.require'packer'.plugin_complete PackerSync lua require('plugins') require('core.utils').packer_sync(<f-args>)"
  end,
})

-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "*",
  command = "set fo-=c fo-=r fo-=o",
})

-- store listed buffers in tab local var
vim.t.bufs = vim.api.nvim_list_bufs()

-- autocmds for tabufline -> store bufnrs on bufadd, bufenter events
-- thx to https://github.com/ii14 & stores buffer per tab -> table
autocmd({ "BufAdd", "BufEnter" }, {
  callback = function(args)
    if vim.t.bufs == nil then
      vim.t.bufs = { args.buf }
    else
      local bufs = vim.t.bufs

      -- check for duplicates
      if not vim.tbl_contains(bufs, args.buf) and (args.event == "BufAdd" or vim.bo[args.buf].buflisted) then
        table.insert(bufs, args.buf)
        vim.t.bufs = bufs
      end
    end
  end,
})

autocmd("BufDelete", {
  callback = function(args)
    for _, tab in ipairs(api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
  end,
})


-- react
vim.cmd [[ autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart ]]

vim.cmd [[ autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear ]]

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

