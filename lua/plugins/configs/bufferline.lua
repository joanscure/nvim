local options = {
	mode = "buffers",
	numbers = "none",
	close_command = "bdelete! %d",
	right_mouse_command = "bdelete! %d",
	left_mouse_command = "buffer %d",
	middle_mouse_command = nil,
	buffer_close_icon = '',
	modified_icon = '●',
	close_icon = '',
	left_trunc_marker = '',
	right_trunc_marker = '',
	name_formatter = function(buf)
		if buf.name:match('%.md') then
			return vim.fn.fnamemodify(buf.name, ':t:r')
		end
	end,
	max_name_length = 18,
	max_prefix_length = 15,
	tab_size = 18,
	offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
	color_icons = true,
	show_buffer_icons = true,
	show_buffer_close_icons = true,
	show_buffer_default_icon = true,
	show_close_icon = true,
	show_tab_indicators = true,
	persist_buffer_sort = true,
	separator_style = "thick",
	enforce_regular_tabs = true,
	always_show_bufferline = true,
	sort_by = 'insert_after_current'
}

require('bufferline').setup({options = options})
