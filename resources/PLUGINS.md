# Plugins instalados

Inventario completo de los plugins definidos en `lua/plugins/*.lua` (lazy.nvim), qué hace cada uno, y dónde hay solapamiento/redundancia. Generado a partir del estado del repo — si agregás o quitás plugins, este archivo puede quedar desactualizado; pedí que se regenere si notás diferencias.

## LSP / Mason — `lsp.lua`

| Plugin | Qué hace |
|---|---|
| `williamboman/mason.nvim` | Instalador de LSP servers, linters, formatters y DAP adapters (`:Mason` para ver/gestionar). |
| `williamboman/mason-lspconfig.nvim` | Puente entre Mason y `nvim-lspconfig`; su `ensure_installed` fuerza la instalación automática de servers al arrancar. |
| `neovim/nvim-lspconfig` | Configuración y arranque de los clientes LSP (`vtsls`, `angularls`, `html`, `cssls`, `jsonls`, `pyright`, `eslint`, `yamlls`, `jdtls`, `lua_ls`, `marksman`, `prismals`). Define `gd`/`gr`/`gi`/`K`/`<leader>rn`/`<leader>ca` on attach. |
| `stevearc/conform.nvim` | Motor de formateo (`prettierd`/`prettier`, `stylua`, `black`, `google-java-format`). `<leader>fm` formatea manual; autoformat on-save solo en Java y Lua. |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Fuerza instalación de formatters/DAP tools que Mason no cubre por defecto (`prettierd`, `stylua`, `black`, `java-debug-adapter`, `java-test`, etc.) vía `:MasonToolsInstall`. |
| `folke/lazydev.nvim` | Autocompletado/tipos correctos de la API de Neovim (`vim.*`) cuando editás Lua de tu propia config. Solo carga en archivos `.lua`. |
| `Bilal2453/luvit-meta` | Tipos de `vim.uv` (libuv) — dependencia de `lazydev`, no se usa solo. |
| `j-hui/fidget.nvim` | Notificación discreta abajo a la derecha del progreso de un LSP (ej. "jdtls: indexando..."). |

## Autocompletado y edición de texto — `coding.lua`

| Plugin | Qué hace |
|---|---|
| `saghen/blink.cmp` | Motor de autocompletado (LSP, path, snippets, buffer). Define `<C-space>`, `<Tab>`/`<S-Tab>`, `<CR>`, `<C-n>`/`<C-p>` en modo inserción. |
| `rafamadriz/friendly-snippets` | Colección de snippets estándar (dependencia de `blink.cmp`). |
| `windwp/nvim-ts-autotag` | Autocierre y auto-rename de tags HTML/JSX al editar (`<div` → `<div></div>`). |
| `numToStr/Comment.nvim` | Comentar/descomentar líneas o bloques (`gcc`, `gc` en visual). |
| `JoosepAlviste/nvim-ts-context-commentstring` | Corrige qué símbolo de comentario usar dentro de archivos con lenguajes embebidos (ej. `<script>` dentro de `.vue`/`.html`). Trabaja junto a `Comment.nvim`. |
| `echasnovski/mini.surround` | Agregar/quitar/cambiar "envoltorios" — comillas, paréntesis, etc. (`sa`, `ds`, `cs`). |
| `echasnovski/mini.ai` | Text objects mejorados y conscientes de Treesitter (`af`/`if` función, `ac`/`ic` clase, `ao`/`io` bloque/condicional/loop). |

## Java — `java.lua`

| Plugin | Qué hace |
|---|---|
| `mfussenegger/nvim-jdtls` | Integración completa de `jdtls` (LSP de Java): organizar imports, extraer variable/constante/método, correr tests, debug bundles, soporte Lombok. Define su propio `on_attach` (independiente del de `lsp.lua`). |

## Sesión — `session.lua`

| Plugin | Qué hace |
|---|---|
| `folke/persistence.nvim` | Guarda y restaura la sesión (buffers/layout abiertos) por directorio de proyecto. `<leader>qs` restaurar, `<leader>ql` restaurar última, `<leader>qd` no guardar al salir. |

## Herramientas — `tools.lua`

| Plugin | Qué hace |
|---|---|
| `windwp/nvim-autopairs` | Autocierre de `()`, `[]`, `{}`, comillas al escribir. |
| `norcalli/nvim-colorizer.lua` | Resalta con el color real los códigos HEX/RGB dentro del código (útil en CSS). |
| `akinsho/toggleterm.nvim` | Terminal integrada con soporte float/horizontal/vertical (`<C-\>` toggle, `<leader>tf/th/tv`). |
| `MagicDuck/grug-far.nvim` | Buscar y reemplazar con regex en todo el proyecto, tipo panel de VSCode (`<leader>sr` global, `<leader>sw` palabra bajo cursor, `<leader>sp` archivo actual). |

## Treesitter — `treesitter.lua`

| Plugin | Qué hace |
|---|---|
| `nvim-treesitter/nvim-treesitter` | Parser de sintaxis real (no regex) para highlighting, indentado y selección incremental (`gnn`, `grn`, `grc`, `grm`). |

## UI extra — `ui-extras.lua`

| Plugin | Qué hace |
|---|---|
| `MeanderingProgrammer/render-markdown.nvim` | Renderiza Markdown "bonito" dentro del buffer (encabezados, tablas, checkboxes, bloques de código). `<leader>um` toggle. |
| `Bekaboo/dropbar.nvim` | Barra de ruta/breadcrumb arriba del buffer (archivo → función → bloque actual), similar al breadcrumb de VSCode. |
| `kevinhwang91/nvim-ufo` | Folding (plegado de código) mejorado basado en Treesitter/indent (`zR`/`zM`/`zr`/`zm`/`zp`). |

## UI general — `ui.lua`

| Plugin | Qué hace |
|---|---|
| `catppuccin/nvim` | Tema de color (mocha), con integraciones para gitsigns/noice/which-key/etc. |
| `nvim-lualine/lualine.nvim` | Barra de estado inferior (modo, git branch, diagnostics, archivo, posición). |
| `akinsho/bufferline.nvim` | Línea de pestañas de buffers arriba (`<Tab>`/`<S-Tab>` para ciclar, `<leader>1-9` ir a buffer N). |
| `nvim-tree/nvim-web-devicons` | Iconos de archivos/carpetas — dependencia visual usada por neo-tree, bufferline, fzf-lua, etc. |
| `stevearc/dressing.nvim` | Mejora los popups nativos de selección/input (`vim.ui.select`, `vim.ui.input`) para que se vean integrados con el tema. |
| `rcarriga/nvim-notify` | Popups de notificación (usado también como backend de `noice.nvim`). |
| `folke/noice.nvim` | Reemplaza la línea de comandos, mensajes y popup de LSP hover/signature por una UI more moderna. |
| `folke/which-key.nvim` | Muestra un popup con las teclas disponibles al empezar a escribir un atajo (ej. tocar `<leader>` y esperar). |

## Editor / navegación / git — `editor.lua`

| Plugin | Qué hace |
|---|---|
| `nvim-neo-tree/neo-tree.nvim` | Explorador de archivos lateral (`<leader>e`). |
| `nvim-lua/plenary.nvim` | Librería de utilidades Lua — dependencia interna de varios plugins (gitsigns, todo-comments, lazygit, telescope-style helpers). No se usa directo. |
| `MunifTanjim/nui.nvim` | Librería de componentes de UI (popups, layouts) — dependencia de `neo-tree` y `noice`. No se usa directo. |
| `ibhagwan/fzf-lua` | Buscador difuso: archivos (`<C-p>`), texto/live grep (`<C-f>`), buffers (`<leader>fb`), help (`<leader>fh`), archivos git (`<leader>fg`), resumir búsqueda (`<leader>fr`), TODOs (`<leader>ft`), diagnostics (`<leader>dd`/`<leader>dD`). |
| `christoomey/vim-tmux-navigator` | Navegación con `<C-h/j/k/l>` entre splits de Neovim y, si estás en una sesión real de tmux, entre panes de tmux también, sin cambiar de tecla. Usa los mapeos por defecto del propio plugin (modo normal), sin config extra. |
| `lewis6991/gitsigns.nvim` | Marca cambios de Git en el gutter línea por línea; stage/reset/preview/blame por hunk (`<leader>hs/hr/hp/hb`, `]c`/`[c`). |
| `folke/todo-comments.nvim` | Resalta y lista comentarios `TODO`/`FIXME`/`HACK`/etc. |
| `kdheepak/lazygit.nvim` | Abre LazyGit (TUI externo) dentro de un float (`<leader>gg`). |
| `mg979/vim-visual-multi` | Cursores múltiples estilo VSCode/Sublime. |

---

## Redundancias / solapamientos detectados

| Caso | Detalle | Sugerencia |
|---|---|---|
| **`dressing.nvim` + `noice.nvim`** | Ambos tocan la capa de UI de Neovim (uno `vim.ui.select/input`, el otro cmdline/mensajes/popups de LSP). No están configurados para pisarse (noice no tiene `override` de `vim.ui.select` activado), pero si en el futuro activás presets de `noice` para inputs, revisa que no dupliquen `dressing`. | Sin acción necesaria por ahora. |

## Resumen

- **Total de plugins con spec propio**: ~42 (sin contar `flash.nvim`, `nvim-treesitter-textobjects`, `trouble.nvim` ni `vim-fugitive`, ya quitados; se sumó `vim-tmux-navigator`).
- **Plugins que son solo dependencias internas** (no se invocan directo): `luvit-meta`, `plenary.nvim`, `nui.nvim`, `nvim-web-devicons`, `friendly-snippets`.
