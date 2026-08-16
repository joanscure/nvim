# Keybindings

`<leader>` = `Space`

---

## General

| Shortcut | Mode | Action |
|-------|------|--------|
| `<Esc>` | n | Clear search highlight |
| `<C-s>` | n | Save all buffers |
| `<Tab>` | n | Next buffer |
| `<S-Tab>` | n | Previous buffer |
| `<leader>1`–`9` | n | Go to buffer N |
| `<` / `>` | v | Indent (keeps selection) |
| `<A-j>` / `<A-k>` | n/i/v | Move line(s) down/up |

---

## LSP

| Shortcut | Mode | Action |
|-------|------|--------|
| `gd` | n | Go to definition |
| `gvd` | n | Go to definition (vsplit) |
| `gr` | n | References |
| `gi` | n | Implementations |
| `K` | n | Hover / documentation |
| `<leader>rn` | n | Rename symbol |
| `<leader>ca` | n | Code actions (fzf-lua) |
| `<leader>fm` | n/v | Format (Conform) |
| `<leader>ci` | n | Formatter info (ConformInfo) |

---

## Diagnostics

> Errors only show an icon in the sign column plus an underline. `gl` shows the full message.

| Shortcut | Mode | Action |
|-------|------|--------|
| `gl` | n | View error in floating window |
| `[d` / `]d` | n | Previous/next diagnostic |
| `<leader>dd` | n | Buffer diagnostics (fzf) |
| `<leader>dD` | n | Workspace diagnostics (fzf) |

---

## Completion (blink.cmp — Insert mode)

| Shortcut | Action |
|-------|--------|
| `<C-Space>` | Show/hide completion menu |
| `<C-e>` | Close menu |
| `<CR>` | Accept suggestion |
| `<Tab>` / `<S-Tab>` | Next/previous item or snippet |
| `<C-n>` / `<C-p>` | Next/previous item |
| `<C-g>` | Show/hide function signature |

---

## Search — fzf-lua

| Shortcut | Mode | Action |
|-------|------|--------|
| `<C-p>` | n | Find files |
| `<C-f>` | n | Live grep project text |
| `<leader>fb` | n | Open buffers |
| `<leader>fh` | n | Help tags |
| `<leader>fg` | n | Git-tracked files |
| `<leader>fr` | n | Resume last search |
| `<leader>ft` | n | Project TODOs |

---

## Search and Replace — grug-far

> Opens an interactive buffer; type the pattern and replacement, results update live.

| Shortcut | Mode | Action |
|-------|------|--------|
| `<leader>sr` | n/v | Open grug-far (selection if in visual mode) |
| `<leader>sw` | n | Search word under cursor |
| `<leader>sp` | n | Search current file only |

---

## Split navigation — vim-tmux-navigator

| Shortcut | Action |
|-------|--------|
| `<C-h>` | Move to left split/pane |
| `<C-j>` | Move to split/pane below |
| `<C-k>` | Move to split/pane above |
| `<C-l>` | Move to right split/pane |

> Default mappings from the plugin itself (normal mode), no extra config
> on top. If you're inside an actual tmux session, it also crosses into
> tmux panes without switching keys. It doesn't touch terminal mode, so
> inside a `:terminal` (ToggleTerm, fzf-lua, etc.) these keys aren't
> intercepted — they go straight to the process.

---

## File explorer — NeoTree

| Shortcut | Action |
|-------|--------|
| `<leader>e` | Toggle explorer |

---

## Git — Gitsigns

| Shortcut | Mode | Action |
|-------|------|--------|
| `]c` / `[c` | n | Next/previous hunk |
| `<leader>hs` | n/v | Stage hunk |
| `<leader>hr` | n/v | Reset hunk |
| `<leader>hS` | n | Stage whole buffer |
| `<leader>hR` | n | Reset whole buffer |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame line (full) |
| `<leader>hd` | n | Diff against index |
| `<leader>hD` | n | Diff against last commit |
| `<leader>td` | n | Show deleted lines |

## Git — LazyGit / Fugitive

| Shortcut | Action |
|-------|--------|
| `<leader>gg` | Open LazyGit |

---

## Terminal — ToggleTerm

| Shortcut | Action |
|-------|--------|
| `<C-\>` | Toggle terminal (float by default) |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |

---

## Folding — UFO

| Shortcut | Action |
|-------|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zr` | Open folds (except some) |
| `zm` | Close folds by level |
| `zp` | Preview fold under cursor |

---

## Sessions — Persistence

| Shortcut | Action |
|-------|--------|
| `<leader>qs` | Restore directory session |
| `<leader>ql` | Restore last global session |
| `<leader>qd` | Don't save session on exit |

---

## Surround — mini.surround

| Shortcut | Action |
|-------|--------|
| `sa` + motion | Add surround |
| `ds` + char | Delete surround |
| `cs` + char | Change surround |

---

## Markdown — render-markdown.nvim

> Activates automatically when opening a `.md` file. Renders headings, tables, code blocks, and inline lists right in the buffer.

| Shortcut | Mode | Action |
|-------|------|--------|
| `<leader>um` | n | Toggle rendering |

---

## Detected conflicts

| Conflict | Detail |
|-----------|---------|
| `[d` / `]d` | Defined in `keymaps.lua` (global) and in `lsp.lua`'s `on_attach` (buffer-local). The buffer-local one takes priority when an LSP is active — no practical effect. |
| `<C-p>` | fzf-lua (normal) and blink.cmp (insert) — different modes, no conflict. |
| `<C-s>` | Save (normal). |
| `<Tab>` | Bufferline (normal) and blink.cmp (insert) — different modes, no conflict. |
