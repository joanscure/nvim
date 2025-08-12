# Neovim Setup (Lazy.nvim + LSP + Productivity)

Fast, modern Neovim config focused on **performance** and **developer ergonomics**. Includes:

* **Lazy.nvim** plugin manager (lazy‑load everything)
* **LSP** for JS/TS (vtsls/tsserver), Lua, HTML/CSS, JSON, Markdown, Prisma, Python
* **nvim-cmp** completion + **LuaSnip**
* **Conform.nvim** for fast formatting (Prettierd/Prettier, Stylua, Black, PrismaFmt)
* **Treesitter** (auto-install parsers, conditional on available C compiler)
* **fzf-lua** fuzzy finder, **NvimTree** file explorer
* Polished UI: Onedark theme, Lualine, Notify, Dressing, Which‑Key, Fidget, Gitsigns, Todo‑comments

---

## Requirements

* **Neovim** ≥ 0.9 (recommended ≥ 0.10)
* **Git** in PATH
* (Optional but recommended) **C compiler** for Treesitter parsers

  * **Windows**: easiest is **Zig** (`winget install -e --id zig.zig`), or **LLVM/Clang** (`winget install -e --id LLVM.LLVM`).

    * If using Clang, you may need **MSVC Build Tools + Windows SDK** (`winget install -e --id Microsoft.VisualStudio.2022.BuildTools`, select *Desktop development with C++*).
  * **macOS**: `xcode-select --install`
  * **Linux**: `sudo apt install build-essential` (Debian/Ubuntu) or `sudo dnf groupinstall "Development Tools"` (Fedora)

> Treesitter loads **only if a compiler is detected**. You can use the config without it; you just won’t get TS highlighting until the compiler is available.

---

## Folder Structure

```
~/.config/nvim/
├─ init.lua
└─ lua/
   ├─ config/
   │  ├─ options.lua
   │  ├─ keymaps.lua
   │  ├─ autocmds.lua
   │  └─ lazy.lua
   └─ plugins/
      └─ init.lua
```

---

## Installation

1. **Backup** your current Neovim config.
2. Copy the files from this repository into `~/.config/nvim` (Linux/macOS) or `%LOCALAPPDATA%\nvim` (Windows).
3. Start Neovim. Lazy.nvim will bootstrap automatically.
4. Run:

   * `:Lazy sync` to install plugins
   * `:Mason` then `:MasonToolsInstall` to install formatters/linters
   * If you have a compiler available: `:TSUpdate` for Treesitter parsers

### Verify compiler (Windows)

* **PowerShell** (open a new session after installation):

  ```powershell
  zig version            # if you installed Zig
  clang --version        # or Clang
  ```
* In **Neovim**:

  ```vim
  :echo executable('zig') || executable('clang') || executable('cl')
  :checkhealth nvim-treesitter
  ```

  Should print `1` for one of them.

---

## Key Plugins

| Area           | Plugin(s)                                                                                                    |
| -------------- | ------------------------------------------------------------------------------------------------------------ |
| Plugin manager | `folke/lazy.nvim`                                                                                            |
| UI             | `navarasu/onedark.nvim`, `nvim-lualine/lualine.nvim`, `rcarriga/nvim-notify`, `stevearc/dressing.nvim`       |
| Navigation     | `ibhagwan/fzf-lua`, `nvim-tree/nvim-tree.lua`, `nvim-tree/nvim-web-devicons`                                 |
| Git            | `lewis6991/gitsigns.nvim`, `tpope/vim-fugitive`                                                              |
| LSP            | `neovim/nvim-lspconfig`, `williamboman/mason.nvim`, `williamboman/mason-lspconfig.nvim`, `folke/neodev.nvim` |
| Completion     | `hrsh7th/nvim-cmp` + `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-nvim-lsp-signature-help`                 |
| Snippets       | `L3MON4D3/LuaSnip` + `rafamadriz/friendly-snippets`                                                          |
| Formatting     | `stevearc/conform.nvim`, `WhoIsSethDaniel/mason-tool-installer.nvim`                                         |
| Treesitter     | `nvim-treesitter/nvim-treesitter`, `nvim-treesitter/nvim-treesitter-textobjects`, `windwp/nvim-ts-autotag`   |
| QoL            | `folke/which-key.nvim`, `folke/todo-comments.nvim`, `j-hui/fidget.nvim`, `echasnovski/mini.surround`         |

---

## Defaults & Opinionated Choices

* **Leader**: Space (`" "`)
* **Theme**: Onedark (darker)
* **Statusline**: Lualine (global statusline)
* **Search**: smartcase, highlight on yank
* **Tabs/Indent**: spaces, width 2 (adjust in `options.lua`)
* **Persistent undo** and sane defaults
* **Performance**: module cache (`vim.loader.enable()`), lazy loading, disabled legacy runtime plugins

---

## LSP & Formatting

* **Servers installed via Mason**: `lua_ls`, `vtsls` (or fallback `ts_ls`), `html`, `cssls`, `jsonls`, `marksman`, `prismals`, `pyright`, `eslint`.
* **Formatting via Conform** (on save, async):

  * JS/TS/React/JSON/CSS/HTML/MD/YAML → `prettierd` → fallback `prettier`
  * Lua → `stylua`
  * Python → `black`
  * Prisma → `prismaFmt`
* LSP keymaps are attached per-buffer (see cheat sheet below).

---

## Keymaps (Cheat Sheet)

> Hold `<leader>` briefly to see available mappings (Which‑Key).

### Navigation & Files

* Toggle file tree: **`<C-b>`**
* Find files: **`<C-p>`** (`fzf-lua`)
* Live grep: **`<C-f>`** (`fzf-lua`)
* Buffers: **`<leader>fb`**
* Help tags: **`<leader>fh`**

### Editing

* Clear search highlight: **`<Esc>`**
* Save all: **`<C-s>`**
* Move line/selection: **`Alt-j / Alt-k`** (normal/insert/visual)
* Comment line/block: **`gcc`** / Visual select then **`gc`**
* Surround: add **`sa`**, delete **`sd`**, replace **`sr`** (e.g., `sa)w` wraps word with `()`)

### LSP

* Definition **`gd`**, References **`gr`**, Implementation **`gi`**
* Hover **`K`**, Rename **`<leader>rn`**, Code Action **`<leader>ca`**
* Diagnostics prev/next **`[d`** / **`]d`**
* Format (Conform) **`Alt-f`**

### Git

* Fugitive: `:G`, `:Git` (status/commits)

### Misc

* Todos: `:TodoQuickFix`
* Health: `:checkhealth`

---

## Customization Tips

* **Change theme**: set another colorscheme in `options.lua` or add your favorite theme plugin.
* **Switch file explorer**: prefer NvimTree by default; you can swap for `neo-tree` if you like.
* **Swap fuzzy finder**: `fzf-lua` is fast and simple; you can replace with Telescope if you need its ecosystem.
* **Treesitter compilers**: preference order is `zig`, `clang`, `cl`, `gcc`, `cc`. You can change this in `plugins/init.lua`.

---

## Troubleshooting

### Treesitter: `fatal error: 'stdlib.h' file not found` (Windows)

* Cause: Clang can’t find MSVC/Windows SDK headers.
* Fix options:

  1. **Use Zig** for Treesitter (recommended): `winget install -e --id zig.zig`, then `:TSUninstall <lang>` and `:TSInstall <lang>`.
  2. Install **MSVC Build Tools + Windows SDK** and reopen terminal, then run `:TSUpdate`.

### “No C compiler found!” on startup

* The config guards Treesitter behind a compiler check, but some plugins may still try to load.
* Ensure your terminal PATH includes `zig` or `clang`/`cl`.
* In Neovim: `:echo executable('zig') || executable('clang') || executable('cl')` → should print `1`.

### LSP not attaching

* Run `:Mason` and ensure the server is installed.
* Check `:LspInfo` to see active clients.

---

## Updating

* Update plugins: `:Lazy sync`
* Update Treesitter parsers: `:TSUpdate`
* Update Mason tools: `:MasonToolsUpdate`

---

## Credits

This setup leans on the excellent work of the Neovim community: Lazy.nvim, Treesitter, nvim-lspconfig, mason, fzf-lua, and many more. ❤️
