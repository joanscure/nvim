if not vim.g.neovide then return end

-- "FontName:hSIZE" — spaces in name must match the Windows-registered family name.
-- Other flags: :b (bold), :i (italic), :w500 (weight). Multiple fonts separated by comma.
-- vim.o.guifont = "GeistMono Nerd Font:h13"
 vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- Window opacity. Range: 0.0 (invisible) → 1.0 (fully opaque)
vim.g.neovide_opacity = 0.92

-- Inner padding in pixels (breathing room between window border and editor content)
vim.g.neovide_padding_top = 8
vim.g.neovide_padding_bottom = 8
vim.g.neovide_padding_right = 10
vim.g.neovide_padding_left = 10

-- Smooth scrolling duration in seconds. Set to 0 to disable.
vim.g.neovide_scroll_animation_length = 0.25

-- How long (seconds) the cursor takes to travel to its new position. 0 = instant.
vim.g.neovide_cursor_animation_length = 0.08

-- Size of the cursor trail. Range: 0.0 (no trail) → 1.0 (long trail)
vim.g.neovide_cursor_trail_size = 0.6

-- Particle effect on top of cursor movement.
-- Values: "" (none), "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"
vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- Hide the mouse pointer while typing
vim.g.neovide_hide_mouse_when_typing = true

-- Target refresh rate in Hz. Match your monitor's refresh rate.
vim.g.neovide_refresh_rate = 60
