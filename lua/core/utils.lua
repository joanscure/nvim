local M = {}
local api = vim.api

local merge_tb = vim.tbl_deep_extend

M.load_mappings = function(section, mapping_opt)
  local function set_section_map(section_values)
	if section_values.plugin then
	  return
	end
	section_values.plugin = nil

	for mode, mode_values in pairs(section_values) do
	  local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
	  for keybind, mapping_info in pairs(mode_values) do
		-- merge default + user opts
		local opts = merge_tb("force", default_opts, mapping_info.opts or {})

		mapping_info.opts, opts.mode = nil, nil
		opts.desc = mapping_info[2]

		vim.keymap.set(mode, keybind, mapping_info[1], opts)
	  end
	end
  end

  local mappings = require "core.mappings"

  if type(section) == "string" then
	mappings[section]["plugin"] = nil
	mappings = { mappings[section] }
  end

  for _, sect in pairs(mappings) do
	set_section_map(sect)
  end
end

M.load_override = function(default_table, plugin_name)
  local user_table = {}
  user_table = type(user_table) == "table" and user_table or user_table()
  return merge_tb("force", default_table, user_table)
end

M.packer_sync = function(...)
  local git_exists, git = pcall(require, "nvchad.utils.git")
  local defaults_exists, defaults = pcall(require, "nvchad.utils.config")
  local packer_exists, packer = pcall(require, "packer")

  if git_exists and defaults_exists then
    local current_branch_name = git.get_current_branch_name()

    -- warn the user if we are on a snapshot branch
    if current_branch_name:match(defaults.snaps.base_snap_branch_name .. "(.+)" .. "$") then
      vim.api.nvim_echo({
        { "WARNING: You are trying to use ", "WarningMsg" },
        { "PackerSync" },
        {
          "you still like to continue? [y/N]\n",
          "WarningMsg",
        },
      }, false, {})

      local ans = vim.trim(string.lower(vim.fn.input "-> "))

      if ans ~= "y" then
        return
      end
    end
  end

  if packer_exists then
    packer.sync(...)
  else
    error "Packer could not be loaded!"
  end
end

M.bufilter = function()
  local bufs = vim.t.bufs

  for i = #bufs, 1, -1 do
    if not vim.api.nvim_buf_is_valid(bufs[i]) then
      table.remove(bufs, i)
    end
  end

  return bufs
end

M.tabuflineNext = function()
  local bufs = M.bufilter() or {}

  for i, v in ipairs(bufs) do
    if api.nvim_get_current_buf() == v then
      vim.cmd(i == #bufs and "b" .. bufs[1] or "b" .. bufs[i + 1])
      break
    end
  end
end

M.tabuflinePrev = function()
  local bufs = M.bufilter() or {}

  for i, v in ipairs(bufs) do
    if api.nvim_get_current_buf() == v then
      vim.cmd(i == 1 and "b" .. bufs[#bufs] or "b" .. bufs[i - 1])
      break
    end
  end
end

-- closes tab + all of its buffers
M.closeAllBufs = function(action)
  local bufs = vim.t.bufs

  if action == "closeTab" then
    vim.cmd "tabclose"
  end

  for _, buf in ipairs(bufs) do
    M.close_buffer(buf)
  end

  if action ~= "closeTab" then
    vim.cmd "enew"
  end
end
M.close_buffer = function(bufnr)
  if vim.bo.buftype == "terminal" then
    vim.cmd(vim.bo.buflisted and "set nobl | enew" or "hide")
  elseif vim.bo.modified then
    print "save the file bruh"
  else
    bufnr = bufnr or api.nvim_get_current_buf()
    require("core.utils").tabuflinePrev()
    vim.cmd("bd" .. bufnr)
  end
end

-- remove plugins defined in chadrc
M.remove_default_plugins = function(plugins)
  local removals = {}

  if not vim.tbl_isempty(removals) then
    for _, plugin in pairs(removals) do
      plugins[plugin] = nil
    end
  end

  return plugins
end

-- merge default/user plugin tables
M.merge_plugins = function(default_plugins)
  local user_plugins = {}

  -- merge default + user plugin table
  default_plugins = merge_tb("force", default_plugins, user_plugins)

  local final_table = {}

  for key, _ in pairs(default_plugins) do
    default_plugins[key][1] = key
    final_table[#final_table + 1] = default_plugins[key]
  end

  return final_table
end

return M

