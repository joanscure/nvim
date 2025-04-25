local keyset = vim.keymap.set

-- Autocomplete with <TAB>
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "<C-r>=coc#rpc#request(\'doKeymap\', [\'snippets-expand-jump\',\'\'])<CR>" : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', opts)

-- Use <CR> to confirm completion or continue line break
keyset("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "\\<C-g>u\\<CR><c-r>=coc#on_enter()<CR>"', opts)

-- Trigger completion with <c-k>
if vim.fn.has("nvim") == 1 then
    keyset("i", "<c-k>", "coc#refresh()", { silent = true, expr = true })
else
    keyset("i", "<c-@>", "coc#refresh()", { silent = true, expr = true })
end

-- Diagnostic navigation
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
keyset("n", "gvd", ":vsplit<CR><Plug>(coc-definition)", { silent = true })
keyset("n", "gf", "<Plug>(coc-type-definition)", { silent = true })
keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Code actions
keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", { silent = true })
keyset("n", "<leader>do", "<Plug>(coc-codeaction)", { silent = true })

-- Show documentation with K
function _G.show_docs()
    if vim.fn.CocAction("hasProvider", "hover") then
        vim.fn.CocActionAsync("doHover")
    else
        vim.api.nvim_feedkeys("K", "in", true)
    end
end
keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

-- Highlight symbol on cursor hold
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Commands
vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })
vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Statusline support
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Symbol renaming
keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

-- Code Lens action
keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", { silent = true })

-- Refactoring
keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Prettier command
vim.api.nvim_create_user_command("Prettier", "CocCommand prettier.forceFormatDocument", {})
