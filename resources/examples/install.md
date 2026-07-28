# Windows Neovim Setup Guide

Guía de instalación completa para dejar esta configuración de Neovim
funcionando en una máquina Windows nueva: LSP, Treesitter, formatters,
Java/Spring Boot y fuentes.

Al terminar, corre el [bootstrap de Mason](#9-mason-bootstrap-ejecutar-una-vez-al-final)
(paso 9) — es el paso que garantiza que `vtsls`, `angularls` y el resto de
servidores LSP queden realmente instalados.

## 1. Core Tools & Package Manager

Corre estos comandos en PowerShell **como Administrador**.

```powershell
# Package manager (Winget viene integrado en Windows 10/11)
winget install --id Git.Git
winget install --id Microsoft.WindowsTerminal

# Neovim
winget install --id Neovim.Neovim

# LazyGit (TUI para Git)
winget install --id JesseDuffield.lazygit
```

## 2. Search & Navigation (dependencias de Telescope/FZF)

```powershell
# Ripgrep (búsqueda rápida)
winget install --id BurntSushi.ripgrep.MSVC

# Fd (búsqueda rápida de archivos)
winget install --id sharkdp.fd

# FZF (binario del fuzzy finder)
winget install --id junegunn.fzf

# The Silver Searcher (alternativa opcional)
winget install --id "The Silver Searcher"

winget install -e --id mbuilov.sed
```

## 3. Runtimes & Compilers

```powershell
# Node.js Version Manager (Volta)
winget install --id Volta.Volta

# Python
winget install --id Python.Python.3
```

### Compilador C (REQUERIDO para los parsers de Treesitter)

`nvim-treesitter` solo se carga si detecta un compilador C en el PATH
(`clang`, `cl`, `zig`, `gcc` o `cc`) — sin esto el plugin ni siquiera
arranca y no hay resaltado de sintaxis para ningún lenguaje.

**Opción A — MSYS2 (recomendada, mejor compatibilidad):**

1. Descarga e instala desde <https://www.msys2.org/>.
2. Abre la terminal **MSYS2** (no PowerShell) y corre:
   ```bash
   pacman -S mingw-w64-x86_64-gcc
   ```
3. **Paso que se suele olvidar:** el instalador de MSYS2 *no* agrega nada
   al PATH de Windows. Agrega `C:\msys64\mingw64\bin` al PATH del usuario
   manualmente, luego abre una terminal nueva y confirma con `gcc --version`:
   ```powershell
   $current = [Environment]::GetEnvironmentVariable("Path", "User")
   [Environment]::SetEnvironmentVariable("Path", "$current;C:\msys64\mingw64\bin", "User")
   ```

**Opción B — Zig (alternativa liviana):**

```powershell
winget install --id zig.zig
```

### tree-sitter-cli (REQUERIDO por nvim-treesitter, branch `main`)

Desde que `nvim-treesitter` pasó a la branch `main` (la vieja `master` quedó
congelada y rota contra el API de query directives de Nvim 0.12+ — crasheaba
al abrir cualquier `.md` con `render-markdown.nvim`), la compilación de
parsers ya no la hace el plugin por su cuenta: delega en el binario oficial
`tree-sitter build`, así que necesitas `tree-sitter-cli` (>= 0.26.1) en el
PATH.

```powershell
winget install --id tree-sitter.tree-sitter-cli
```

Abre una terminal nueva y confirma con `tree-sitter --version`.

**Gotcha:** `tree-sitter build` en Windows intenta usar `cl.exe` (MSVC) por
defecto aunque sigas la Opción A de arriba (MSYS2/gcc) — y si no tienes
Visual Studio instalado, la compilación de *todos* los parsers falla con
`Error: program not found`. La solución es forzar el compilador vía la
variable de entorno `CC` (persistente, de usuario):

```powershell
[Environment]::SetEnvironmentVariable("CC", "gcc", "User")
```

(Si usaste la Opción B — Zig, pon `[Environment]::SetEnvironmentVariable("CC", "zig cc", "User")` en su lugar.)
Abre una terminal nueva después de esto y corre `:TSUpdate` dentro de Neovim
para (re)compilar todos los parsers de `ensure_installed`.

## 4. Language Dependencies & Formatters

> Cierra y vuelve a abrir la terminal después del paso 3 para que el PATH
> quede actualizado.

```powershell
# Provider de Python para Neovim
pip install pynvim

# Provider y herramientas de Node.js
# (instala primero una versión de node con Volta, p.ej. 'volta install node')
npm install -g neovim
npm install -g @fsouza/prettierd
npm install -g vscode-langservers-extracted
```

## 5. System Configuration

```powershell
# Habilita rutas largas (evita errores con node_modules muy anidados)
# Correr en CMD o PowerShell como Administrador:
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
```

## 6. Java Development (Spring Boot / WebFlux)

> Mason auto-instala `jdtls`, `java-debug-adapter`, `java-test` y
> `google-java-format` en el primer arranque. Solo necesitas instalar
> manualmente el JDK y las build tools de abajo.

```powershell
# JDK 21 (Eclipse Temurin — recomendado)
winget install --id EclipseAdoptium.Temurin.21.JDK
```

Configura `JAVA_HOME` después de instalar (como Administrador):

```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot", "Machine")
```

O vía la GUI de Windows: *Panel de Control > Sistema > Opciones avanzadas
> Variables de entorno > Variables del sistema > Nueva* — variable
`JAVA_HOME`, valor `C:\Program Files\Eclipse Adoptium\jdk-21.x.x.x-hotspot`
(ajusta la versión).

Verifica la instalación (reinicia la terminal primero):

```powershell
java -version   # debe mostrar openjdk 21
echo %JAVA_HOME%
```

Build tools (instala al menos una):

```powershell
winget install --id Apache.Maven
winget install --id Gradle.Gradle

# Spring Boot CLI (opcional — para scaffolding con 'spring init')
winget install --id VMware.SpringBoot
```

**Lombok:** viene incluido automáticamente por Mason dentro del paquete
`jdtls`. No requiere instalación manual — la config lo recoge de
`C:\mason\packages\jdtls\lombok.jar` en Windows (o
`~/.local/share/nvim/mason/packages/jdtls/lombok.jar` en Linux).

**Herramientas de Mason instaladas automáticamente** (sin acción manual):

| Herramienta | Función |
|---|---|
| `jdtls` | Servidor de lenguaje para Java |
| `java-debug-adapter` | Soporte DAP para debugging |
| `java-test` | Integración de test runner |
| `google-java-format` | Formatter de código (usado por `conform.nvim`) |

## 7. Fonts (requeridas para los íconos)

Instala manualmente las Nerd Fonts incluidas en esta config:

1. Ve a `%LOCALAPPDATA%\nvim\resources\JetBrainsMono\`.
2. Selecciona todos los archivos `.ttf`.
3. Clic derecho → **Instalar**.

## 8. Angular — dependencia por proyecto

`angularls` (el binario) lo instala Mason automáticamente, pero para que el
LSP funcione completo dentro de un proyecto Angular (ir a definición dentro
de templates, autocompletado, etc.) el propio proyecto también necesita
`@angular/language-service` como devDependency:

```bash
npm install --save-dev @angular/language-service
```

## 9. Mason Bootstrap (ejecutar una vez, al final)

Mason auto-instala los servidores LSP y herramientas en el primer arranque
de Neovim, pero eso depende de que `node`/`npm` ya estén en el PATH en ese
momento exacto. Si ese primer intento falla silenciosamente (por ejemplo,
si abriste Neovim antes de que los shims de Volta estuvieran en el PATH de
la sesión), servidores como `vtsls` o `angularls` quedan sin instalar sin
ningún aviso, y cosas como el soporte de TypeScript/Angular o `gd` (go to
definition) simplemente no funcionan hasta que lo notas y lo arreglas
manualmente.

Corre esto una vez, en una terminal nueva, después de completar los pasos
1–8:

```powershell
# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
```

```bash
# Linux
chmod +x bootstrap.sh && ./bootstrap.sh
```

Ambos scripts viven en esta misma carpeta (`resources/examples/`) y
fuerzan la instalación —esperando a que cada una termine de verdad, no solo
la disparan y cierran Neovim— de:

- **LSP servers** (vía `bootstrap.lua`, con espera bloqueante):
  `vtsls`, `angularls`, `html`, `cssls`, `jsonls`, `jdtls`, `yamlls`,
  `eslint`, `marksman`, `prismals`, `pyright`, `intelephense`, `dockerls`,
  `docker_compose_language_service`.
- **Formatters/DAP tools** de `mason-tool-installer` (vía
  `:MasonToolsInstallSync`): `prettierd`, `prettier`, `stylua`, `black`,
  `prisma-language-server`, `google-java-format`, `java-debug-adapter`,
  `java-test`.

Verifica el resultado con `:Mason` dentro de Neovim — todo debe aparecer
con ✓ instalado.

> Este bootstrap solo hace falta correrlo **una vez por máquina nueva**.
> No necesitas repetirlo salvo que borres `mason/` por completo o agregues
> un servidor nuevo a `ensure_installed` y quieras forzar su instalación
> sin esperar al auto-install normal de Neovim.

### Gotcha en Windows: un espacio en tu carpeta de usuario rompe cosas

Si tu carpeta de usuario tiene un espacio (p.ej. `C:\Users\Joan Leyton`),
varias herramientas que invocan `cmd.exe` internamente en cadena (Mason
para servidores Node como `angularls`/`eslint`, y el paso de compilación
de parsers de Treesitter, que hace un `move` sin comillas) rompen con
errores tipo `'C:\Users\Joan' no se reconoce como un comando` o
`Acceso denegado` al mover el `.so` compilado. Esto es un defecto de
Windows/`cmd.exe`, no de esta config, y no depende de qué tan largo sea
el nombre — solo de que tenga un espacio.

La solución de raíz son **dos variables de entorno** (persistentes, de
usuario) que sacan todo lo que se instala/compila de esa ruta:

```powershell
# Todo lo que Neovim descarga/compila (plugins de lazy.nvim, parsers de
# Treesitter, sesiones, shada) se mueve de %LOCALAPPDATA%\nvim-data a
# C:\xdg-data\nvim-data
[Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "C:\xdg-data", "User")

# Mason (los binarios de los LSP servers) a una ruta fija sin espacios
# (ya reflejado en lsp.lua via install_root_dir), mas su bin en el PATH:
[Environment]::SetEnvironmentVariable("Path", "$([Environment]::GetEnvironmentVariable('Path','User'));C:\mason\bin", "User")
```

Abre una terminal nueva después de correr esto y confirma con
`Get-Command vtsls` y `nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c qa`.

En Linux no hace falta nada de esto — las rutas de usuario no llevan
espacios por convención y Mason/Treesitter usan sus ubicaciones por
defecto (`~/.local/share/nvim/...`) sin problema.

## 10. Troubleshooting

### Crash al abrir cualquier `.md`: `attempt to call method 'range' (a nil value)`

**Síntoma** — al abrir un archivo Markdown (o al togglear `render-markdown.nvim`),
Neovim tira este traceback:

```
vim.schedule callback: .../vim/treesitter.lua:196: attempt to call method 'range' (a nil value)
stack traceback:
    .../vim/treesitter.lua:196: in function 'get_range'
    .../vim/treesitter.lua:231: in function 'get_node_text'
    .../nvim-treesitter/lua/nvim-treesitter/query_predicates.lua:141: in function 'handler'
    .../vim/treesitter/query.lua:868: in function '_apply_directives'
    ...
    .../render-markdown.nvim/lua/render-markdown/core/ui.lua:...: in function 'render'
```

**Causa raíz** — Nvim 0.12 eliminó el knob de compatibilidad `all=false` que
la branch `master` (legacy) de `nvim-treesitter` usaba para recibir un solo
`TSNode` en los handlers de sus query directives custom. Con `all=false` ya
no soportado, cada capture llega como lista (`TSNode[]`), así que la
directive `#set-lang-from-info-string!` (la que decide el lenguaje de un
code fence dentro de un `.md` para hacer syntax highlighting del bloque)
agarra la lista entera en vez de un nodo y explota al llamarle `:range()`.
No es un bug de esta config ni de `render-markdown.nvim` — es
`nvim-treesitter` `master` desactualizado contra el API actual de Nvim
(confirmado diffeando contra la branch `main`, que ya eliminó esa directive
y resuelve el lenguaje del fence directamente vía `@injection.language`).

**Fix aplicado** — se migró `nvim-treesitter` de `master` a `main`
(`lua/plugins/treesitter.lua`), la única branch que sigue recibiendo fixes
para versiones actuales de Nvim. Esto trae dos requisitos nuevos que no
existían con `master` — ver la sección **"tree-sitter-cli (REQUERIDO por
nvim-treesitter, branch `main`)"** más arriba en el paso 3:

1. `tree-sitter-cli` instalado (`winget install --id tree-sitter.tree-sitter-cli`).
2. La variable de entorno `CC` apuntando a un compilador real (`gcc` si
   usaste MSYS2, `zig cc` si usaste Zig) — sin esto, `tree-sitter build`
   intenta usar `cl.exe` (MSVC) por defecto y falla la compilación de
   **todos** los parsers con `Error: program not found`, aunque tengas
   gcc/zig en el PATH.

`main` también dropeó el módulo `incremental_selection` (los keymaps
`gnn`/`grn`/`grc`/`grm` de la config vieja) sin reemplazo — si no los usabas,
no hay nada que hacer; si los necesitás, hay que reimplementarlos a mano
(no vienen en el core de Nvim).

### Warning `[nvim-treesitter] warning: skipping unsupported language: <nombre>`

Es esperado y no requiere acción — sale la primera vez que se abre un
buffer cuyo filetype no es un lenguaje real de Treesitter (p.ej. `notify`
de `nvim-notify`, `TelescopePrompt`, `lazy`, `qf`). El autocomando de
`FileType` en `plugins/treesitter.lua` filtra contra
`require("nvim-treesitter.parsers")` antes de intentar instalar/arrancar,
así que en teoría no debería aparecer más; si reaparece para un lenguaje
real (no un filetype de UI de plugin), es señal de que ese parser no está
en `ensure_installed`.
