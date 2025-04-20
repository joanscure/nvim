-- Asegúrate de que lazy.nvim esté instalado
local install_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(install_path) then
    vim.fn.system({
        'git', 'clone', '--filter=blob:none', '--single-branch', '--depth=1',
        'https://github.com/folke/lazy.nvim.git', install_path
    })
end
vim.opt.runtimepath:prepend(install_path)

-- Configura los plugins usando lazy.nvim
require('lazy').setup({
    -- IDE y herramientas
    {
        'neoclide/coc.nvim',
        branch = 'master',
        build = 'npm ci', -- Comando de construcción de coc.nvim
        config = function()
            -- Configuración de coc.nvim en Lua
            vim.g.coc_snippet_next = '<tab>'
            vim.g.coc_global_extensions = {
                '@yaegassy/coc-intelephense',
                'coc-json',
                'coc-html',
                'coc-eslint',
                'coc-emmet',
                'coc-angular',
                'coc-css',
                'coc-sql',
                'coc-tsserver',
                'coc-prettier',
                'coc-flutter',
                'coc-snippets',
                'coc-react-refactor',
                'coc-pairs',
                'coc-htmlhint',
                'coc-prisma',
                'coc-fzf-preview',
            }

            -- Agregar coc-prettier si existe node_modules/prettier
            if vim.fn.isdirectory('./node_modules/prettier') == 1 then
                table.insert(vim.g.coc_global_extensions, 'coc-prettier')
            end

            -- Agregar coc-eslint si existe node_modules/eslint
            if vim.fn.isdirectory('./node_modules/eslint') == 1 then
                table.insert(vim.g.coc_global_extensions, 'coc-eslint')
            end
        end
    },
    'morhetz/gruvbox',
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            -- Configura colorizer.lua
            require 'colorizer'.setup()
        end
    },
    'stevearc/vim-vscode-snippets',
    -- 'L3MON4D3/LuaSnip',  -- Descomenta si necesitas LuaSnip
    -- 'stephpy/vim-php-cs-fixer',

    -- Nvim Tree
    {
      'navarasu/onedark.nvim',
      config = function()
        require('onedark').setup {
            style = 'darker'
        }
        require('onedark').load()
      end
    },
    'nvim-tree/nvim-web-devicons',
    {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require("nvim-tree").setup{
          sync_root_with_cwd = false,
          filters = {
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            custom = { 'node_modules', 'dist', '.git', '.yarn', '.vscode', '.bundle' },
          },
          auto_reload_on_write = false,
          view = {
            adaptive_size = false,
            side = "right",
            width = 30,
            preserve_window_proportions = true,
          },
          git = {
            enable = true,
            ignore = true,
            timeout = 5000,
          },
          diagnostics = {
            enable = false,
          },
          hijack_directories = {
            enable = false,
            auto_open = false,
          },
          update_focused_file = {
            enable = true,
            update_root = false,
          },
          filesystem_watchers = {
            enable = true,
          },
          actions = {
            use_system_clipboard = true,
            change_dir = {
              enable = true,
              global = false,
              restrict_above_cwd = false,
            },
            expand_all = {
              max_folder_discovery = 300,
              exclude = {},
            },
            file_popup = {
              open_win_config = {
                col = 1,
                row = 1,
                relative = "cursor",
                border = "shadow",
                style = "minimal",
              },
            },
            open_file = {
              quit_on_open = true,
              resize_window = true,
              window_picker = {
                enable = true,
                chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                exclude = {
                  filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
                  buftype = { "nofile", "terminal", "help" },
                },
              },
            },
            remove_file = {
              close_window = true,
            },
          },
        }
      end
    },

    -- Otros plugins útiles
    'scrooloose/nerdcommenter',
    'christoomey/vim-tmux-navigator',
    'junegunn/gv.vim',
    'alvan/vim-closetag',
    'tpope/vim-repeat',
    -- 'Exafunction/codeium.vim',
   {
      'ggandor/leap.nvim',
      config = function()
        require('leap').add_default_mappings()
      end
    },
    'ayu-theme/ayu-vim',

    -- Plugins de Git
    'airblade/vim-gitgutter',
    'tpope/vim-fugitive',

    -- Plugins FZF
    { 'junegunn/fzf', build = ':FzfInstall' },
    {
        'ibhagwan/fzf-lua',
        config = function()
            -- Configuración de fzf-lua
            require('fzf-lua').setup({
                -- Puedes agregar opciones aquí si lo deseas
                fzf_bin = 'fzf',  -- Ejemplo de configuración adicional
                winopts = {
                      border = 'rounded', -- Bordes redondeados
                      hl = {
                          normal = 'Normal',
                          border = 'FloatBorder',
                          cursor = 'Cursor',
                          cursorline = 'CursorLine',
                          search = 'IncSearch',
                      }
                  },
                  fzf_opts = {
                      ['--color'] = 'fg:#ebdbb2,bg:#282828,hl:#fabd2f',
                      ['--color'] = 'fg+:#ebdbb2,bg+:#3c3836,hl+:#fe8019',
                      ['--color'] = 'info:#83a598,prompt:#b8bb26,pointer:#fb4934',
                      ['--color'] = 'marker:#fabd2f,spinner:#d3869b,header:#458588',
                  }
            })
        end
    },

    -- Plugins de tipado
    {
        'kylechui/nvim-surround',
        config = function()
          require("nvim-surround").setup({
            keymaps = {
              insert = "<C-g>s",
              insert_line = "<C-g>S",
              normal = "ys",
              normal_cur = "yss",
              normal_line = "yS",
              normal_cur_line = "ySS",
              visual = "S",
              visual_line = "gS",
              delete = "ds",
              change = "cs",
              change_line = "cS",
            }
          })
        end
    },
    'prisma/vim-prisma',

    -- Plugins de UI
    {
      'nvim-lualine/lualine.nvim',
      config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'ayu_dark',
            component_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = { 'NvimTree' },
            always_divide_middle = true,
            globalstatus = false,
          },
          sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { 'filename' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {},
          },
          tabline = {},
          extensions = {},
        }
      end
    },
    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons', -- Asegúrate de que los íconos estén instalados
        config = function()
            -- Configuración de bufferline
            require('bufferline').setup({})
        end
    },

    -- Otros plugins
    'mg979/vim-visual-multi',
    'editorconfig/editorconfig-vim',
    'gregsexton/MatchTag',
    {
        'akinsho/toggleterm.nvim',
        config = function()
          require("toggleterm").setup{
            size = 20,
            open_mapping = [[<c-\>]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            autochdir = false,
            insert_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
              border = "curved",
              winblend = 3,
            },
          }
        end
    },

    -- Lenguajes
    -- 'dart-lang/dart-vim-plugin',
    'othree/yajs.vim',
    'pangloss/vim-javascript'
})
