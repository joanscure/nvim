# Installed plugins

Full inventory of the plugins defined in `lua/plugins/*.lua` (lazy.nvim), what each one does, and where there's overlap/redundancy. Generated from the state of the repo — if you add or remove plugins, this file can go stale; ask for it to be regenerated if you notice differences.

## LSP / Mason — `lsp.lua`

| Plugin | What it does |
|---|---|
| `williamboman/mason.nvim` | Installer for LSP servers, linters, formatters, and DAP adapters (`:Mason` to view/manage). |
| `williamboman/mason-lspconfig.nvim` | Bridge between Mason and `nvim-lspconfig`; its `ensure_installed` forces automatic installation of servers on startup. |
| `neovim/nvim-lspconfig` | Configures and starts the LSP clients (`vtsls`, `angularls`, `html`, `cssls`, `jsonls`, `pyright`, `eslint`, `yamlls`, `jdtls`, `lua_ls`, `marksman`, `prismals`) via the native `vim.lsp.config`/`vim.lsp.enable` API. `vtsls` registers `@angular/language-server` as a global plugin (TS-aware Angular integration); `angularls` still runs for template diagnostics, with `renameProvider` disabled to avoid duplicating the rename dialog. Defines `gd`/`gr`/`gi`/`K`/`<leader>rn`/`<leader>ca` on attach. |
| `b0o/SchemaStore.nvim` | Catalog of JSON Schemas (static table, no network at runtime) used by `jsonls` and `yamlls` for completion/validation of `package.json`, k8s manifests, GitHub Actions, etc. |
| `stevearc/conform.nvim` | Formatting engine (`prettierd`/`prettier`, `stylua`, `black`, `google-java-format`). `<leader>fm` formats manually; format-on-save is on for Lua/JSON/YAML/CSS/Python (Java and JS/TS are pending, once verified manually). |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Forces installation of formatters/linters/DAP tools Mason doesn't cover by default (`prettierd`, `stylua`, `black`, `google-java-format`, `java-debug-adapter`, `java-test`, `ruff`, `hadolint`, `stylelint`, `phpcs`) via `:MasonToolsInstall`. |
| `mfussenegger/nvim-lint` (`lint.lua`) | Real linting beyond LSP diagnostics: `ruff` (python), `hadolint` (dockerfile), `stylelint` (css), `phpcs` (php). JS/TS deliberately has no linter here — the `eslint` server already covers that. |
| `folke/lazydev.nvim` | Correct autocomplete/types for the Neovim API (`vim.*`) when editing Lua in your own config. Only loads in `.lua` files. |
| `Bilal2453/luvit-meta` | Types for `vim.uv` (libuv) — a dependency of `lazydev`, not used on its own. |
| `j-hui/fidget.nvim` | Discreet bottom-right notification of LSP progress (e.g. "jdtls: indexing..."). |

## Autocompletion and text editing — `coding.lua`

| Plugin | What it does |
|---|---|
| `saghen/blink.cmp` | Completion engine (LSP, path, snippets, buffer). Defines `<C-space>`, `<Tab>`/`<S-Tab>`, `<CR>`, `<C-n>`/`<C-p>` in insert mode. |
| `rafamadriz/friendly-snippets` | Collection of standard snippets (dependency of `blink.cmp`). |
| `windwp/nvim-ts-autotag` | Auto-close and auto-rename HTML/JSX tags while editing (`<div` → `<div></div>`). |
| `numToStr/Comment.nvim` | Comment/uncomment lines or blocks (`gcc`, `gc` in visual mode). |
| `JoosepAlviste/nvim-ts-context-commentstring` | Picks the right comment symbol inside files with embedded languages (e.g. `<script>` inside `.vue`/`.html`). Works alongside `Comment.nvim`. |
| `echasnovski/mini.surround` | Add/remove/change "wrappers" — quotes, parens, etc. (`sa`, `ds`, `cs`). |
| `echasnovski/mini.ai` | Improved, Treesitter-aware text objects (`af`/`if` function, `ac`/`ic` class, `ao`/`io` block/conditional/loop). |

## Java — `java.lua`

| Plugin | What it does |
|---|---|
| `mfussenegger/nvim-jdtls` | Full `jdtls` (Java LSP) integration: organize imports, extract variable/constant/method, run tests, debug bundles, Lombok support. Defines its own `on_attach` (independent of the one in `lsp.lua`). Formatting does NOT go through jdtls (`format.enabled = false`) — `google-java-format` handles it via `conform.nvim` (see `lsp.lua`). |

## Session — `session.lua`

| Plugin | What it does |
|---|---|
| `folke/persistence.nvim` | Saves and restores the session (open buffers/layout) per project directory. `<leader>qs` restore, `<leader>ql` restore last, `<leader>qd` don't save on exit. |

## Tools — `tools.lua`

| Plugin | What it does |
|---|---|
| `windwp/nvim-autopairs` | Auto-closes `()`, `[]`, `{}`, quotes while typing. |
| `norcalli/nvim-colorizer.lua` | Highlights HEX/RGB color codes in code with their actual color (useful in CSS). |
| `akinsho/toggleterm.nvim` | Integrated terminal with float/horizontal/vertical support (`<C-\>` toggle, `<leader>tf/th/tv`). |
| `MagicDuck/grug-far.nvim` | Project-wide search and replace with regex, VSCode-panel style (`<leader>sr` global, `<leader>sw` word under cursor, `<leader>sp` current file). |

## Treesitter — `treesitter.lua`

| Plugin | What it does |
|---|---|
| `nvim-treesitter/nvim-treesitter` | Real (non-regex) syntax parser for highlighting, indentation, and incremental selection (`gnn`, `grn`, `grc`, `grm`). |

## Extra UI — `ui-extras.lua`

| Plugin | What it does |
|---|---|
| `MeanderingProgrammer/render-markdown.nvim` | Renders "pretty" Markdown right in the buffer (headings, tables, checkboxes, code blocks). `<leader>um` toggle. |
| `Bekaboo/dropbar.nvim` | Path/breadcrumb bar above the buffer (file → function → current block), similar to VSCode's breadcrumb. |
| `kevinhwang91/nvim-ufo` | Improved code folding based on Treesitter/indent (`zR`/`zM`/`zr`/`zm`/`zp`). |

## General UI — `ui.lua`

| Plugin | What it does |
|---|---|
| `catppuccin/nvim` | Color theme (mocha), with integrations for gitsigns/noice/which-key/etc. |
| `nvim-lualine/lualine.nvim` | Bottom statusline (mode, git branch, diagnostics, file, position). |
| `akinsho/bufferline.nvim` | Buffer tab line at the top (`<Tab>`/`<S-Tab>` to cycle, `<leader>1-9` to jump to buffer N). |
| `nvim-tree/nvim-web-devicons` | File/folder icons — visual dependency used by neo-tree, bufferline, fzf-lua, etc. |
| `stevearc/dressing.nvim` | Improves native selection/input popups (`vim.ui.select`, `vim.ui.input`) so they match the theme. |
| `rcarriga/nvim-notify` | Notification popups (also used as the backend for `noice.nvim`). |
| `folke/noice.nvim` | Replaces the command line, messages, and LSP hover/signature popups with a more modern UI. |
| `folke/which-key.nvim` | Shows a popup with available keys as you start typing a keybinding (e.g. pressing `<leader>` and waiting). |

## Editor / navigation / git — `editor.lua`

| Plugin | What it does |
|---|---|
| `nvim-neo-tree/neo-tree.nvim` | Side file explorer (`<leader>e`). |
| `nvim-lua/plenary.nvim` | Lua utility library — internal dependency of several plugins (gitsigns, todo-comments, lazygit, telescope-style helpers). Not used directly. |
| `MunifTanjim/nui.nvim` | UI component library (popups, layouts) — dependency of `neo-tree` and `noice`. Not used directly. |
| `ibhagwan/fzf-lua` | Fuzzy finder: files (`<C-p>`), text/live grep (`<C-f>`), buffers (`<leader>fb`), help (`<leader>fh`), git files (`<leader>fg`), resume last search (`<leader>fr`), TODOs (`<leader>ft`), diagnostics (`<leader>dd`/`<leader>dD`). |
| `christoomey/vim-tmux-navigator` | Navigate with `<C-h/j/k/l>` between Neovim splits and, if you're in an actual tmux session, tmux panes too, without switching keys. Uses the plugin's own default mappings (normal mode), no extra config. |
| `lewis6991/gitsigns.nvim` | Marks Git changes in the gutter line by line; stage/reset/preview/blame per hunk (`<leader>hs/hr/hp/hb`, `]c`/`[c`). |
| `folke/todo-comments.nvim` | Highlights and lists `TODO`/`FIXME`/`HACK`/etc. comments. |
| `kdheepak/lazygit.nvim` | Opens LazyGit (external TUI) inside a float (`<leader>gg`). |
| `mg979/vim-visual-multi` | VSCode/Sublime-style multiple cursors. |

---

## Detected redundancies/overlaps

| Case | Detail | Suggestion |
|---|---|---|
| **`dressing.nvim` + `noice.nvim`** | Both touch Neovim's UI layer (one `vim.ui.select/input`, the other cmdline/messages/LSP popups). They're not configured to step on each other (noice doesn't have its `vim.ui.select` override enabled), but if you enable noice's input presets in the future, check they don't duplicate `dressing`. | No action needed for now. |

## Summary

- **Total plugins with their own spec**: ~44 (not counting `flash.nvim`, `nvim-treesitter-textobjects`, `trouble.nvim`, or `vim-fugitive`, already removed; added `vim-tmux-navigator`, `SchemaStore.nvim`, and `nvim-lint`).
- **Plugins that are internal dependencies only** (not invoked directly): `luvit-meta`, `plenary.nvim`, `nui.nvim`, `nvim-web-devicons`, `friendly-snippets`, `SchemaStore.nvim`.
