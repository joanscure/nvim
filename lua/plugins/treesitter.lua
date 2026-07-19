local function has_c_compiler()
  for _, c in ipairs({ "clang", "cl", "zig", "gcc", "cc" }) do
    if vim.fn.executable(c) == 1 then return true end
  end
  return false
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    cond = has_c_compiler,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
          return ok and stats and stats.size > 100 * 1024
        end,
      },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "json", "css", "html", "markdown", "markdown_inline", "python", "prisma", "java", "yaml" },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    },
    config = function(_, opts)
      local install = require("nvim-treesitter.install")
      install.compilers = { "zig", "clang", "cl", "gcc", "cc" }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
