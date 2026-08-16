# Neovim Config (lazy.nvim + LSP + Java/Spring Boot)

Personal Neovim config built around **lazy.nvim**, the native
`vim.lsp.config`/`vim.lsp.enable` LSP API, and Mason-managed servers.
Tuned for JS/TS/Angular, Java/Spring Boot, Python, and general web work,
with an eye on Windows compatibility (MSYS2/gcc, `tree-sitter-cli`, the
Mason-install-path-with-spaces gotcha, etc.).

## Documentation

- **[docs/install.md](docs/install.md)** — full setup guide for a new
  Windows machine: core tools, C compiler for Treesitter, Java/Spring
  Boot, fonts, first-launch Mason verification, and troubleshooting for
  the gotchas this config has actually hit.
- **[docs/plugins.md](docs/plugins.md)** — inventory of every plugin in
  `lua/plugins/*.lua`, grouped by file, with what each one does and any
  detected overlap.
- **[docs/keybindings.md](docs/keybindings.md)** — full keybinding
  cheat sheet.
- **[docs/keybindings.html](docs/keybindings.html)** — the same
  keybindings as a searchable standalone page (open it directly in a
  browser).

## Highlights

- **lazy.nvim** plugin manager, lazy-loaded by default (`defaults.lazy = true`)
- **LSP** via Mason + `nvim-lspconfig`: `vtsls`/`angularls` (JS/TS/Angular),
  `jdtls` (Java, via `nvim-jdtls` with Lombok/debug/test support),
  `pyright`, `html`/`cssls`/`jsonls`/`yamlls`, `marksman`, `prismals`,
  `intelephense`, `dockerls`
- **blink.cmp** for completion
- **conform.nvim** for formatting (`prettierd`/`prettier`, `stylua`,
  `black`, `google-java-format`) + `nvim-lint` for linting
  (`ruff`, `hadolint`, `stylelint`, `phpcs`)
- **Treesitter** (`main` branch), parsers built via `tree-sitter-cli`,
  conditional on a detected C compiler
- **fzf-lua** fuzzy finder, **Neo-tree** file explorer, **LazyGit**
  integration
- Catppuccin theme, Lualine, Bufferline, Noice, Notify, Dropbar,
  Which-Key, Fidget, Gitsigns, Todo-comments

See [docs/plugins.md](docs/plugins.md) for the complete list.

## Folder structure

```
%LOCALAPPDATA%\nvim\      (Windows)  /  ~/.config/nvim/  (Linux/macOS)
├─ init.lua
├─ docs/                   setup guide, plugin inventory, keybindings
├─ resources/              fonts, images
└─ lua/
   ├─ config/               options, keymaps, autocmds, lazy.nvim bootstrap
   └─ plugins/               one file per plugin group (lsp, coding, java, ui, ...)
```

## Quick start

1. Back up your current Neovim config.
2. Copy this repo's files into `~/.config/nvim` (Linux/macOS) or
   `%LOCALAPPDATA%\nvim` (Windows).
3. On Windows, follow **[docs/install.md](docs/install.md)** first — it
   covers required system dependencies (C compiler, `tree-sitter-cli`,
   fonts, Java toolchain) that Neovim itself can't install for you.
4. Start Neovim. lazy.nvim bootstraps itself and installs plugins.
5. Open any real file (not just `nvim` with no arguments) and let Mason
   install LSP servers/formatters in the background — check progress
   and results with `:Mason`.
6. If you have a C compiler available, parsers build automatically on
   plugin install; otherwise run `:TSUpdate` once one is on PATH.

## Updating

- Plugins: `:Lazy sync`
- Treesitter parsers: `:TSUpdate`
- Mason tools: `:MasonToolsUpdate` (or `:MasonToolsUpdateSync` to block
  until it finishes)
