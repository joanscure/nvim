# Keybindings

`<leader>` = `Space`

---

## General

| Atajo | Modo | Acción |
|-------|------|--------|
| `<Esc>` | n | Limpiar resaltado de búsqueda |
| `<C-s>` | n | Guardar todos los buffers |
| `<Tab>` | n | Siguiente buffer |
| `<S-Tab>` | n | Buffer anterior |
| `<leader>1`–`9` | n | Ir al buffer N |
| `<` / `>` | v | Indentar (mantiene selección) |
| `<A-j>` / `<A-k>` | n/i/v | Mover línea(s) abajo/arriba |

---

## LSP

| Atajo | Modo | Acción |
|-------|------|--------|
| `gd` | n | Ir a definición |
| `gvd` | n | Ir a definición (vsplit) |
| `gr` | n | Referencias |
| `gi` | n | Implementaciones |
| `K` | n | Hover / documentación |
| `<leader>rn` | n | Renombrar símbolo |
| `<leader>ca` | n | Code actions (fzf-lua) |
| `<leader>fm` | n/v | Formatear (Conform) |
| `<leader>ci` | n | Info de formatters (ConformInfo) |

---

## Diagnósticos

> Los errores solo muestran ícono en el signo + subrayado. `gl` muestra el mensaje completo.

| Atajo | Modo | Acción |
|-------|------|--------|
| `gl` | n | Ver error en floating window |
| `[d` / `]d` | n | Diagnóstico anterior/siguiente |
| `<leader>dd` | n | Diagnósticos del buffer (fzf) |
| `<leader>dD` | n | Diagnósticos del workspace (fzf) |

---

## Autocompletado (blink.cmp — modo Insert)

| Atajo | Acción |
|-------|--------|
| `<C-Space>` | Mostrar/ocultar autocompletado |
| `<C-e>` | Cerrar menú |
| `<CR>` | Aceptar sugerencia |
| `<Tab>` / `<S-Tab>` | Siguiente/anterior ítem o snippet |
| `<C-n>` / `<C-p>` | Siguiente/anterior ítem |
| `<C-g>` | Mostrar/ocultar firma de función |

---

## Búsqueda — fzf-lua

| Atajo | Modo | Acción |
|-------|------|--------|
| `<C-p>` | n | Buscar archivos |
| `<C-f>` | n | Buscar texto en proyecto (live grep) |
| `<leader>fb` | n | Buffers abiertos |
| `<leader>fh` | n | Help tags |
| `<leader>fg` | n | Archivos tracked por git |
| `<leader>fr` | n | Retomar última búsqueda |
| `<leader>ft` | n | TODOs del proyecto |

---

## Búsqueda y Reemplazo — grug-far

> Abre un buffer interactivo; escribe el patrón y reemplazo, los resultados se actualizan en vivo.

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>sr` | n/v | Abrir grug-far (selección si es modo v) |
| `<leader>sw` | n | Buscar palabra bajo el cursor |
| `<leader>sp` | n | Buscar solo en el archivo actual |

---

## Navegación entre splits — vim-tmux-navigator

| Atajo | Acción |
|-------|--------|
| `<C-h>` | Moverse al split/pane izquierdo |
| `<C-j>` | Moverse al split/pane de abajo |
| `<C-k>` | Moverse al split/pane de arriba |
| `<C-l>` | Moverse al split/pane derecho |

> Mapeos por defecto del propio plugin (modo normal), sin config nuestra
> encima. Si estás dentro de una sesión real de tmux, cruza también a los
> panes de tmux sin cambiar de tecla. No toca terminal mode, así que dentro
> de un `:terminal` (ToggleTerm, fzf-lua, etc.) estas teclas no se
> interceptan — llegan directo al proceso.

---

## Explorador de archivos — NeoTree

| Atajo | Acción |
|-------|--------|
| `<leader>e` | Abrir/cerrar explorador |

---

## Git — Gitsigns

| Atajo | Modo | Acción |
|-------|------|--------|
| `]c` / `[c` | n | Siguiente/anterior hunk |
| `<leader>hs` | n/v | Stage hunk |
| `<leader>hr` | n/v | Revertir hunk |
| `<leader>hS` | n | Stage buffer completo |
| `<leader>hR` | n | Reset buffer completo |
| `<leader>hp` | n | Preview hunk |
| `<leader>hb` | n | Blame de la línea (completo) |
| `<leader>hd` | n | Diff contra index |
| `<leader>hD` | n | Diff contra último commit |
| `<leader>td` | n | Mostrar líneas borradas |

## Git — LazyGit / Fugitive

| Atajo | Acción |
|-------|--------|
| `<leader>gg` | Abrir LazyGit |

---

## Terminal — ToggleTerm

| Atajo | Acción |
|-------|--------|
| `<C-\>` | Toggle terminal (float por defecto) |
| `<leader>tf` | Terminal flotante |
| `<leader>th` | Terminal horizontal |
| `<leader>tv` | Terminal vertical |

---

## Folding — UFO

| Atajo | Acción |
|-------|--------|
| `zR` | Abrir todos los folds |
| `zM` | Cerrar todos los folds |
| `zr` | Abrir folds (excepto algunos) |
| `zm` | Cerrar folds por nivel |
| `zp` | Preview del fold bajo el cursor |

---

## Sesiones — Persistence

| Atajo | Acción |
|-------|--------|
| `<leader>qs` | Restaurar sesión del directorio |
| `<leader>ql` | Restaurar última sesión global |
| `<leader>qd` | No guardar sesión al salir |

---

## Surround — mini.surround

| Atajo | Acción |
|-------|--------|
| `sa` + motion | Añadir surround |
| `ds` + char | Borrar surround |
| `cs` + char | Cambiar surround |

---

## Markdown — render-markdown.nvim

> Se activa automáticamente al abrir un `.md`. Renderiza headings, tablas, code blocks y listas inline dentro del buffer.

| Atajo | Modo | Acción |
|-------|------|--------|
| `<leader>um` | n | Activar/desactivar renderizado |

---

## Conflicts detectados

| Conflicto | Detalle |
|-----------|---------|
| `[d` / `]d` | Definidos en `keymaps.lua` (global) y en `lsp.lua` `on_attach` (buffer-local). El buffer-local tiene prioridad cuando hay LSP activo — sin efecto práctico. |
| `<C-p>` | fzf-lua (normal) y blink.cmp (insert) — modos distintos, sin conflicto. |
| `<C-s>` | Guardar (normal). |
| `<Tab>` | Bufferline (normal) y blink.cmp (insert) — modos distintos, sin conflicto. |
