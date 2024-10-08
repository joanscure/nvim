let g:loaded = 1
let g:loaded_netrwPlugin = 1


lua << EOF

require("nvim-tree").setup{
sync_root_with_cwd = false,
filters = {
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = { 'node_modules','dist','.git' ,'.yarn', '.vscode', '.bundle'},
    },
auto_reload_on_write =  false,
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

EOF
