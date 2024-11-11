-- Configuración global de FZF
vim.env.FZF_DEFAULT_OPTS = '--layout=reverse'
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden'

-- Definir el comando Files usando fzf
vim.api.nvim_create_user_command('Files', function(opts)
    local args = opts.args or ''
    vim.fn['fzf#vim#files'](args, { options = { '--layout=reverse', '--info=inline', '--preview', 'cat {}' } })
end, { bang = true, nargs = '?' })

-- Configuración de la acción de fzf (ctrl-t, ctrl-x, etc.)
vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
}

-- Configuración de colores de fzf
vim.g.fzf_colors = {
    fg = { 'fg', 'Normal' },
    bg = { 'bg', 'Normal' },
    hl = { 'fg', 'Comment' },
    fg_plus = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
    bg_plus = { 'bg', 'CursorLine', 'CursorColumn' },
    hl_plus = { 'fg', 'Statement' },
    info = { 'fg', 'PreProc' },
    border = { 'fg', 'Label' },
    prompt = { 'fg', 'Conditional' },
    pointer = { 'fg', 'Exception' },
    marker = { 'fg', 'Keyword' },
    spinner = { 'fg', 'Label' },
    header = { 'fg', 'Comment' },
}

-- Agregar al PATH si es necesario (en este caso para Windows)
vim.env.PATH = "C:/Program Files/Git/usr/bin;" .. vim.env.PATH
