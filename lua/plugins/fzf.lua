-- Configuración global de FZF
vim.env.FZF_DEFAULT_OPTS = '--layout=reverse'
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"' -- Evita archivos en .git

-- Definir el comando Files usando fzf-lua
vim.api.nvim_create_user_command('Files', function(opts)
    local args = opts.args or ''
    require('fzf-lua').files({
        prompt = 'Files> ',
        previewer = 'bat', -- Usa bat si está instalado
        fzf_opts = { 
            ['--layout'] = 'reverse', 
            ['--info'] = 'inline' 
        },
    })
end, { bang = true, nargs = '?' })

-- Configuración de la acción de fzf (ctrl-t, ctrl-x, etc.)
vim.g.fzf_action = {
    ['ctrl-t'] = 'tab split',
    ['ctrl-x'] = 'split',
    ['ctrl-v'] = 'vsplit',
}

vim.env.PATH = "C:/Program Files/Git/usr/bin;" .. vim.env.PATH

