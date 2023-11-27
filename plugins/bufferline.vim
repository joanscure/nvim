
nnoremap <silent><TAB> :BufferLineCycleNext<CR>
nnoremap <silent><S-TAB> :BufferLineCyclePrev<CR>
lua << EOF
require('bufferline').setup {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    numbers = "none",
    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
    buffer_close_icon = '󰅖',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = 'coc',
    diagnostics_update_in_insert = false,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}},
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_buffer_default_icon = true,
    show_close_icon = true,
show_tab_indicators  = false,
    persist_buffer_sort = true,
    separator_style = {"",""},
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'insert_after_current'
  },
  highlights = {
      background = {
                fg="#8a8a8a"
            }, 
 buffer_selected = {
                bold = true,
                italic = false,
            },
indicator_selected = {
                fg = '#e4e4e4',
            },
    }
}
EOF
