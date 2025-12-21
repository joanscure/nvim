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
    dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects", cond = has_c_compiler } },
    opts = {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "json", "css", "html", "markdown", "markdown_inline", "python", "prisma" },
      incremental_selection = { enable = true },
      textobjects = { select = { enable = true } },
    },
    config = function(_, opts)
      local install = require("nvim-treesitter.install")
      install.compilers = { "zig", "clang", "cl", "gcc", "cc" }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
