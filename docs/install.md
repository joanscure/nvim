# Windows Neovim Setup Guide

Complete setup guide to get this Neovim config working on a fresh Windows
machine: LSP, Treesitter, formatters, Java/Spring Boot, and fonts.

Mason installs LSP servers and formatters/linters automatically the first
time you open a real file in Neovim — no separate bootstrap step needed.
See [step 9](#9-first-launch--verifying-mason) for how to verify it went
through, and what to do if a package failed.

## 1. Core Tools & Package Manager

Run these commands in PowerShell **as Administrator**.

```powershell
# Package manager (Winget ships built-in on Windows 10/11)
winget install --id Git.Git
winget install --id Microsoft.WindowsTerminal

# Neovim
winget install --id Neovim.Neovim

# LazyGit (Git TUI)
winget install --id JesseDuffield.lazygit
```

## 2. Search & Navigation (Telescope/FZF dependencies)

```powershell
# Ripgrep (fast search)
winget install --id BurntSushi.ripgrep.MSVC

# Fd (fast file search)
winget install --id sharkdp.fd

# FZF (fuzzy finder binary)
winget install --id junegunn.fzf

# The Silver Searcher (optional alternative)
winget install --id "The Silver Searcher"

winget install -e --id mbuilov.sed
```

## 3. Runtimes & Compilers

```powershell
# Node.js version manager — any of them works, as long as node/npm
# end up on PATH. Volta is one option, not a requirement; nvm-windows
# (nvm4w) works just as well.
winget install --id Volta.Volta
# or, alternative: winget install --id CoreyButler.NVMforWindows

# Python
winget install --id Python.Python.3
```

### C compiler (REQUIRED for Treesitter parsers)

`nvim-treesitter` only loads if it detects a C compiler on PATH
(`clang`, `cl`, `zig`, `gcc`, or `cc`) — without one the plugin doesn't
even start, and there's no syntax highlighting for any language.

**Option A — MSYS2 (recommended, best compatibility):**

1. Download and install from <https://www.msys2.org/>.
2. Open the **MSYS2** terminal (not PowerShell) and run:
   ```bash
   pacman -S mingw-w64-x86_64-gcc
   ```
3. **Commonly missed step:** the MSYS2 installer does *not* add anything
   to the Windows PATH. Add `C:\msys64\mingw64\bin` to your user PATH
   manually, then open a new terminal and confirm with `gcc --version`:
   ```powershell
   $current = [Environment]::GetEnvironmentVariable("Path", "User")
   [Environment]::SetEnvironmentVariable("Path", "$current;C:\msys64\mingw64\bin", "User")
   ```

**Option B — Zig (lightweight alternative):**

```powershell
winget install --id zig.zig
```

**Option C — WinLibs (simpler than MSYS2, a single winget install):**

A standalone MinGW-w64 GCC, no need to open a separate MSYS2 terminal
or run `pacman`. The winget installer itself adds its `mingw64\bin` to
the user PATH.

```powershell
winget install --id BrechtSanders.WinLibs.POSIX.UCRT
```

Open a new terminal and confirm with `gcc --version`.

### tree-sitter-cli (REQUIRED by nvim-treesitter, `main` branch)

Since `nvim-treesitter` moved to the `main` branch (the old `master` is
frozen and broken against Nvim 0.12+'s query-directive API — it crashed
opening any `.md` file with `render-markdown.nvim`), parser compilation
is no longer handled by the plugin itself: it delegates to the official
`tree-sitter build` binary, so you need `tree-sitter-cli` (>= 0.26.1) on
PATH.

```powershell
winget install --id tree-sitter.tree-sitter-cli
```

Open a new terminal and confirm with `tree-sitter --version`.

**Gotcha:** `tree-sitter build` on Windows tries to use `cl.exe` (MSVC)
by default even if you followed Option A above (MSYS2/gcc) — and if you
don't have Visual Studio installed, compilation of *every* parser fails
with `Error: program not found`. The fix is to force the compiler via
the `CC` environment variable (persistent, user-scoped):

```powershell
[Environment]::SetEnvironmentVariable("CC", "gcc", "User")
```

(If you used Option B — Zig, use
`[Environment]::SetEnvironmentVariable("CC", "zig cc", "User")` instead.)
Open a new terminal after this and run `:TSUpdate` inside Neovim to
(re)compile all the parsers in `ensure_installed`.

## 4. Language Dependencies & Formatters

> Close and reopen your terminal after step 3 so the PATH changes take
> effect.

```powershell
# Python provider for Neovim
pip install pynvim

# Node.js provider and tools
# (install a Node version first via your version manager, e.g. 'volta install node')
npm install -g neovim
npm install -g @fsouza/prettierd
npm install -g vscode-langservers-extracted
```

## 5. System Configuration

```powershell
# Enable long paths (avoids errors with deeply nested node_modules)
# Run in CMD or PowerShell as Administrator:
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
```

## 6. Java Development (Spring Boot / WebFlux)

> Mason auto-installs `jdtls`, `java-debug-adapter`, `java-test`, and
> `google-java-format` on first launch. You only need to manually
> install the JDK and build tools below.

```powershell
# JDK 21 (Eclipse Temurin — recommended)
winget install --id EclipseAdoptium.Temurin.21.JDK
```

`nvim-jdtls` (see `java.lua`) only requires JDK 17+ to run — 21 is
recommended because Eclipse JDT LS (the server behind `jdtls`) runs
better on a recent runtime, but that's the LSP server's own runtime,
not your code's target. Your projects can keep compiling against
Java 17 (or whatever) via their own `pom.xml`/`build.gradle` with no
conflict.

Set `JAVA_HOME` after installing (as Administrator):

```powershell
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Eclipse Adoptium\jdk-21.0.10.7-hotspot", "Machine")
```

Or via the Windows GUI: *Control Panel > System > Advanced system
settings > Environment Variables > System variables > New* — variable
`JAVA_HOME`, value `C:\Program Files\Eclipse Adoptium\jdk-21.x.x.x-hotspot`
(adjust the version).

Verify the install (restart your terminal first):

```powershell
java -version   # should show openjdk 21
echo %JAVA_HOME%
```

Build tools — **only if the project doesn't ship a wrapper.** Most
Java/Spring Boot projects include `gradlew`/`gradlew.bat` or
`mvnw`/`mvnw.cmd`, which download their own isolated copy of the build
tool — that's enough, nothing else to install. Only install
Maven/Gradle globally if you need to run `mvn`/`gradle` directly
(without a wrapper) or for scaffolding with `spring init`:

```powershell
winget install --id Apache.Maven
winget install --id Gradle.Gradle

# Spring Boot CLI (optional — for scaffolding with 'spring init')
winget install --id VMware.SpringBoot
```

**Lombok:** bundled automatically by Mason inside the `jdtls` package.
No manual install needed — the config picks it up from
`C:\mason\packages\jdtls\lombok.jar` on Windows (or
`~/.local/share/nvim/mason/packages/jdtls/lombok.jar` on Linux).

**Tools Mason installs automatically** (no manual action):

| Tool | Purpose |
|---|---|
| `jdtls` | Java language server |
| `java-debug-adapter` | DAP support for debugging |
| `java-test` | Test runner integration |
| `google-java-format` | Code formatter (used by `conform.nvim`) |

## 7. Fonts (required for icons)

Manually install the Nerd Fonts bundled with this config:

1. Go to `%LOCALAPPDATA%\nvim\resources\JetBrainsMono\`.
2. Select all `.ttf` files.
3. Right-click → **Install**.

## 8. Angular — per-project dependency

Mason installs the `angularls` binary automatically, but for the LSP to
work fully inside an Angular project (go-to-definition inside
templates, autocomplete, etc.) the project itself also needs
`@angular/language-service` as a devDependency:

```bash
npm install --save-dev @angular/language-service
```

## 9. First launch & verifying Mason

Mason auto-installs LSP servers and tools the moment you open a real
file (its plugins are lazy-loaded on `BufReadPre`/`BufNewFile` — just
running `nvim` with no file argument won't trigger it). Open any real
file, e.g. `nvim somefile.lua`, and let it run in the background for a
minute or two.

Check the result with `:Mason` inside Neovim — everything should show
up installed (✓). It installs:

- **LSP servers** (via `mason-lspconfig`'s `ensure_installed`):
  `vtsls`, `angularls`, `html`, `cssls`, `jsonls`, `jdtls`, `yamlls`,
  `eslint`, `marksman`, `prismals`, `pyright`, `intelephense`,
  `dockerls`, `docker_compose_language_service`.
- **Formatters/DAP tools** (via `mason-tool-installer`): `prettierd`,
  `prettier`, `stylua`, `black`, `prisma-language-server`,
  `google-java-format`, `java-debug-adapter`, `java-test`.

If something is missing, install it manually from inside Neovim rather
than reaching for an external script:

```
:MasonInstall <package-name>
:MasonToolsInstallSync
```

One case where a package can fail with `Lockfile exists, installation
is already running in another process`: two Neovim processes tried to
install the same package at the same time (e.g. two windows opened
close together). It's harmless — just re-run the install for the
packages that failed.

### Windows gotcha: a space in your user folder breaks things

If your user folder has a space in it (e.g. `C:\Users\Joan Leyton`),
several tools that shell out to `cmd.exe` internally (Mason for Node
servers like `angularls`/`eslint`, and the Treesitter parser build
step, which runs an unquoted `move`) break with errors like
`'C:\Users\Joan' is not recognized as a command` or `Access denied`
when moving the compiled `.so`. This is a Windows/`cmd.exe` defect, not
something in this config, and it doesn't depend on how long the name
is — only on whether it has a space.

The root fix is this environment variable (persistent, user-scoped)
that moves everything Neovim downloads/compiles out of that path:

```powershell
# Everything Neovim downloads/compiles (lazy.nvim plugins, Treesitter
# parsers, sessions, shada) moves from %LOCALAPPDATA%\nvim-data to
# C:\xdg-data\nvim-data
[Environment]::SetEnvironmentVariable("XDG_DATA_HOME", "C:\xdg-data", "User")
```

`install_root_dir` in `lsp.lua` already pins Mason to `C:\mason`
(no spaces) regardless of username, so that specific problem doesn't
depend on this variable. That said, if you want to invoke Mason
binaries (`vtsls`, `jdtls`, `google-java-format`, etc.) directly from a
terminal outside of Neovim, it's worth adding its `bin` to PATH —
mason.nvim already prepends it to PATH **inside** the Neovim session
automatically (`PATH = "prepend"` in `lsp.lua`), so this is only for use
outside of Neovim, not a requirement for the LSP to work:

```powershell
[Environment]::SetEnvironmentVariable("Path", "$([Environment]::GetEnvironmentVariable('Path','User'));C:\mason\bin", "User")
```

Open a new terminal after running this and confirm with
`Get-Command vtsls` and
`nvim --headless -c "lua print(vim.fn.stdpath('data'))" -c qa`.

None of this is needed on Linux — user paths don't have spaces by
convention, and Mason/Treesitter use their default locations
(`~/.local/share/nvim/...`) without issue.

## 10. Troubleshooting

### LSP fails with "failed to spawn" / formatters say "unavailable", even though the binary is already in `mason/bin`

**Symptom** — `nvim-lspconfig` throws `Spawning language server with
cmd: 'vscode-json-language-server' ... failed. The language server is
either not installed, missing from PATH, or not executable.` (or the
same for `vscode-eslint-language-server`), and/or `conform.nvim` warns
"Formatters unavailable for javascript file" — even though
`mason/bin/*.cmd` does exist on disk.

**Root cause** — `lua/config/lazy.lua` sets `defaults = { lazy = true }`.
`mason.nvim`, `mason-lspconfig.nvim`, and `mason-tool-installer.nvim`
had no trigger of their own (`event`/`ft`/`keys`, or just `cmd`, which
doesn't count as an automatic one). With `lazy = true` as the default, a
plugin with no trigger **never loads on its own** — nothing forces it to
run `require(...).setup()` on Neovim startup. `mason.nvim` is the one
that prepends `mason/bin` to `$PATH`; if its `setup()` never runs, that
`$PATH` never gets updated, and `nvim-lspconfig`/`conform.nvim` try to
spawn binaries using only the system `PATH`, where they're not present.

You can check this on any machine with:

```bash
nvim --headless -c 'lua vim.defer_fn(function()
  local lazy = require("lazy.core.config")
  for name, p in pairs(lazy.plugins) do
    if name:match("mason") then print(name, p._.loaded ~= nil) end
  end
  print("PATH has mason:", vim.env.PATH:find("mason") ~= nil)
  vim.cmd("qa")
end, 2000)'
```

If it prints `loaded=false` for all three mason plugins and `PATH has
mason: false`, this is the bug (confirmed on two separate machines).

**Fix applied** — added `event = { "BufReadPre", "BufNewFile" }` (the
same event `nvim-lspconfig` uses) to `mason.nvim`,
`mason-lspconfig.nvim`, and `mason-tool-installer.nvim` in
`lua/plugins/lsp.lua`, plus `dependencies = { "mason.nvim" }` on
`mason-tool-installer.nvim`. That makes all three load when any file is
opened, before an LSP or formatter needs to spawn. Reconfirmed with the
same command above: all three come back `loaded=true` and `PATH has
mason: true`.

> Note: for the same reason, `google-java-format`'s `command` in
> `conform.nvim` uses a fixed path (`.../mason/bin/google-java-format.cmd`)
> instead of resolving it via `vim.fn.exepath(...)` — that `opts` table
> is evaluated once when `conform.nvim` loads, with no guaranteed
> ordering relative to `mason.nvim` (they share the same `event`), so
> relying on `PATH` there would be more fragile than the fixed path.

### Crash opening any `.md` file: `attempt to call method 'range' (a nil value)`

**Symptom** — opening a Markdown file (or toggling
`render-markdown.nvim`), Neovim throws this traceback:

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

**Root cause** — Nvim 0.12 removed the `all=false` compatibility knob
that `nvim-treesitter`'s legacy `master` branch used to receive a
single `TSNode` in its custom query-directive handlers. With `all=false`
no longer supported, every capture arrives as a list (`TSNode[]`), so
the `#set-lang-from-info-string!` directive (which decides the language
of a code fence inside a `.md` file for syntax highlighting) grabs the
whole list instead of a node and blows up calling `:range()` on it.
This isn't a bug in this config or in `render-markdown.nvim` — it's
`nvim-treesitter` `master` being out of date against Nvim's current API
(confirmed by diffing against the `main` branch, which already removed
that directive and resolves the fence's language directly via
`@injection.language`).

**Fix applied** — migrated `nvim-treesitter` from `master` to `main`
(`lua/plugins/treesitter.lua`), the only branch still receiving fixes
for current Nvim versions. This brings two new requirements that didn't
exist with `master` — see the **"tree-sitter-cli (REQUIRED by
nvim-treesitter, `main` branch)"** section above in step 3:

1. `tree-sitter-cli` installed (`winget install --id tree-sitter.tree-sitter-cli`).
2. The `CC` environment variable pointing at a real compiler (`gcc` if
   you used MSYS2, `zig cc` if you used Zig) — without it,
   `tree-sitter build` defaults to `cl.exe` and fails compiling **every**
   parser with `Error: program not found`, even with gcc/zig on PATH.

`main` also dropped the `incremental_selection` module (the
`gnn`/`grn`/`grc`/`grm` keymaps from the old config) with no
replacement — if you weren't using them, there's nothing to do; if you
need them, they'd have to be reimplemented by hand (they're not part of
Nvim core).

### Warning `[nvim-treesitter] warning: skipping unsupported language: <name>`

Expected, no action needed — appears the first time you open a buffer
whose filetype isn't an actual Treesitter language (e.g. `notify` from
`nvim-notify`, `TelescopePrompt`, `lazy`, `qf`). The `FileType`
autocommand in `plugins/treesitter.lua` filters against
`require("nvim-treesitter.parsers")` before attempting to
install/start, so in theory it shouldn't show up anymore; if it
reappears for an actual language (not a plugin UI filetype), that's a
sign that parser is missing from `ensure_installed`.

## Appendix: Windows Terminal setup

### Open a new tab/pane in the same directory

To make a new Windows Terminal tab or pane inherit the current
directory, set the terminal title via the OSC 9;9 escape sequence in
your shell prompt.

**Command Prompt (cmd.exe):**

```
set PROMPT=$e]9;9;$P$e\%PROMPT%
setx PROMPT "%PROMPT%"
```

**PowerShell** (add to your `$PROFILE`):

```powershell
function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation

  $out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) "
  return $out
}
```

### Freeing up keys Windows Terminal grabs by default

Windows Terminal binds several keys by default that this config also
uses inside Neovim (`<C-f>` for live grep, `<A-j>`/`<A-k>`/`<A-arrows>`
for moving lines/panes, etc.), so Terminal intercepts them before Neovim
ever sees them. Add this to the `"actions"` array in Windows Terminal's
`settings.json` (open it via `Ctrl+,` → *Open JSON file*) to unbind
them:

```json
{ "command": "unbound", "keys": "ctrl+comma" },
{ "command": "unbound", "keys": "ctrl+shift+w" },
{ "command": "unbound", "keys": "ctrl+d" },
{ "command": "unbound", "keys": "ctrl+f" },
{ "command": "unbound", "keys": "ctrl+space" },
{ "command": "unbound", "keys": "ctrl+shift+f" },
{ "command": "unbound", "keys": "ctrl+shift+n" },
{ "command": "unbound", "keys": "ctrl+alt+down" },
{ "command": "unbound", "keys": "ctrl+alt+left" },
{ "command": "unbound", "keys": "ctrl+alt+up" },
{ "command": "unbound", "keys": "ctrl+alt+right" },
{ "command": "unbound", "keys": "alt+down" },
{ "command": "unbound", "keys": "alt+left" },
{ "command": "unbound", "keys": "alt+up" },
{ "command": "unbound", "keys": "alt+right" },
{ "command": "unbound", "keys": "alt+shift+right" },
{ "command": "unbound", "keys": "alt+shift+down" },
{ "command": "unbound", "keys": "alt+shift+left" },
{ "command": "unbound", "keys": "alt+shift+up" },
{ "command": "duplicateTab", "keys": "ctrl+shift+d" },
{ "command": { "action": "closeTab" }, "keys": "ctrl+f4" }
```
