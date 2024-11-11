-- Mapeos de teclas
vim.api.nvim_set_keymap('i', '<silent><expr> <TAB>',
  [[coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()]], { noremap = true, silent = true, expr = true })

-- Función CheckBackspace en Lua
function CheckBackspace()
    local col = vim.fn.col('.') - 1
    return col == 0 or string.match(vim.fn.getline('.'), col - 1, col) == '%s'
end

-- Mapeos para navegar entre los diagnósticos
vim.api.nvim_set_keymap('n', '[g', '<Plug>(coc-diagnostic-prev)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']g', '<Plug>(coc-diagnostic-next)', { noremap = true, silent = true })

-- Mapeos para navegación de código
vim.api.nvim_set_keymap('n', 'gd', '<Plug>(coc-definition)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gvd', ':vsplit<CR><Plug>(coc-definition)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gf', '<Plug>(coc-type-definition)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', '<Plug>(coc-implementation)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', '<Plug>(coc-references)', { noremap = true, silent = true })

-- Mapeo para la acción de código (código seleccionado)
vim.api.nvim_set_keymap('x', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>a', '<Plug>(coc-codeaction-selected)', { noremap = true, silent = true })

-- Mapeo para mostrar documentación
vim.api.nvim_set_keymap('n', 'K', ':call ShowDocumentation()<CR>', { noremap = true, silent = true })

-- Función para mostrar documentación en Lua
function ShowDocumentation()
    if vim.fn['CocAction']('hasProvider', 'hover') then
        vim.fn['CocActionAsync']('doHover')
    else
        vim.fn.feedkeys('K', 'in')
    end
end

-- Resaltado de símbolos cuando el cursor está sobre ellos
vim.cmd([[
autocmd CursorHold * silent call CocActionAsync('highlight')
]])

-- Comando Format para formatear el documento
vim.api.nvim_create_user_command('Format', 'CocCommand editor.action.formatDocument', {})

-- Comando para organizar imports
vim.api.nvim_create_user_command('OR', 'CocCommand editor.action.organizeImports', {})

-- Añadir soporte para el statusline de coc.nvim
vim.opt.statusline = '%{coc#status()}%{get(b:,"coc_current_function","")}'

-- Mapeo para navegar en el menú de autocompletado
vim.api.nvim_set_keymap('i', '<silent><expr><S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<silent><expr> <CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], { noremap = true, silent = true, expr = true })
