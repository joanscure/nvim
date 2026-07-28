local function has_c_compiler()
  for _, c in ipairs({ "clang", "cl", "zig", "gcc", "cc" }) do
    if vim.fn.executable(c) == 1 then return true end
  end
  return false
end

-- Tamaño máximo de archivo para activar highlighting (evita cuelgues en
-- archivos grandes, igual que el `highlight.disable` de la config vieja).
local MAX_FILESIZE = 100 * 1024

local ensure_installed = {
  "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "json", "css",
  "html", "markdown", "markdown_inline", "python", "prisma", "java", "yaml",
  "php", "dockerfile",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- "main" es el rewrite oficial (requiere Nvim 0.12+, que ya tenemos) y
    -- el único que recibe fixes: "master" quedó congelado y roto contra el
    -- API de query directives de Nvim 0.12+ (crasheaba al abrir .md, ver
    -- injections.scm de markdown). Requiere tree-sitter-cli en el PATH
    -- (ver resources/examples/install.md).
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    cond = has_c_compiler,
    config = function()
      local ts = require("nvim-treesitter")
      ts.install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nvim_treesitter_start", { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match) or ev.match

          -- Filetypes de UI de plugins (notify, TelescopePrompt, lazy, qf...)
          -- no son lenguajes de Treesitter: sin este check, install() los
          -- intenta igual y loguea un warning "unsupported language" por cada uno.
          if not require("nvim-treesitter.parsers")[lang] then
            return
          end

          if not vim.tbl_contains(ts.get_installed("parsers"), lang) then
            local ok_install = pcall(function() ts.install({ lang }):wait(120000) end)
            if not ok_install then return end
          end

          local ok_stat, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(ev.buf))
          if ok_stat and stats and stats.size > MAX_FILESIZE then
            return
          end

          if not pcall(vim.treesitter.start, ev.buf, lang) then
            return
          end
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
