let g:loaded = 1
let g:loaded_netrwPlugin = 1


lua << EOF

require("nvim-tree").setup{
sync_root_with_cwd = false,
auto_reload_on_write =  false,
view = {
side = "right",
     },
hijack_directories = {
  enable = false,
  auto_open = false,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    },
    filesystem_watchers = {
      enable = false,
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
