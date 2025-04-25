
# Neovim Configuration

Este repositorio contiene mi configuración personal para **Neovim**, optimizada para desarrollo web, con soporte para múltiples lenguajes y herramientas como **Coc.nvim**, **FZF**, **AG**, **Ripgrep**, y más. La configuración está diseñada para proporcionar una experiencia fluida, moderna y eficiente.

## Contenido

- **Coc.nvim**: Autocompletado inteligente y administración de lenguajes.
- **FZF**: Buscador rápido de archivos, proyectos y más.
- **AG (The Silver Searcher)**: Búsqueda rápida dentro de proyectos.
- **Ripgrep (rg)**: Herramienta de búsqueda eficiente.
- **Lualine**: Barra de estado altamente configurable.
- **Nvim-tree**: Explorador de archivos en el lado.
- **Bufferline**: Administración de buffers (pestañas) de manera intuitiva.
- **ToggleTerm**: Terminal dentro de Neovim.
- **Leaps.nvim**: Mapeo de saltos rápidos.
- **Nvim-surround**: Manipulación de elementos delimitados (paréntesis, comillas, etc.).

## Requisitos

- **Neovim** versión 0.8 o superior.
- **Node.js**: Asegúrate de tener **Node.js** instalado y gestionado mediante **Volta**.
- **Ripgrep (rg)**: Para realizar búsquedas rápidas dentro de los proyectos.
- **The Silver Searcher (AG)**: Alternativa a Ripgrep para búsqueda en proyectos.
- **FZF**: Instalado globalmente en el sistema para mejorar la experiencia de búsqueda.

### Instalación de herramientas

#### FZF

1. **Windows**:
   - Si tienes **Git Bash** o **Cygwin** instalado, puedes usar el siguiente comando:
   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```
   - Si prefieres usar un instalador precompilado, sigue la [guía de instalación oficial](https://github.com/junegunn/fzf#installation).

2. **Linux/macOS**:
   ```bash
   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
   ~/.fzf/install
   ```

#### Ripgrep

1. **Windows**:
   - Si usas **Volta**, simplemente puedes instalar **Ripgrep** a través de **Volta**:
     ```bash
     volta install ripgrep
     ```

2. **Linux/macOS**:
   ```bash
   brew install ripgrep
   ```

#### The Silver Searcher (AG)

1. **Windows**:
   - En **Windows**, puedes instalar **AG** mediante **Scoop** o **Chocolatey**:
     ```bash
     scoop install ag
     ```
     o
     ```bash
     choco install ag
     ```

2. **Linux/macOS**:
   ```bash
   brew install the_silver_searcher
   ```

## Instalación de Neovim

1. **Instalación de Neovim en Windows**:
   - Usa el instalador de Neovim disponible en [neovim.io](https://neovim.io) o instálalo a través de **Scoop**:
     ```bash
     scoop install neovim
     ```

2. **Instalación de Neovim en Linux/macOS**:
   - En **macOS** y **Linux**, puedes usar **Homebrew**:
     ```bash
     brew install neovim
     ```

## Configuración

La configuración de Neovim se encuentra en el archivo `init.vim` (o `init.lua` si prefieres usar Lua). Puedes clonarlo o copiar el archivo en tu configuración de Neovim.

### Pasos de instalación:

1. Clona este repositorio en tu directorio de configuración de Neovim:
   ```bash
   git clone https://github.com/tu-usuario/tu-repo-nvim ~/.config/nvim
   ```

2. Instala los plugins de **Vim-Plug** o **Lazy.nvim** (según prefieras).

3. Instala las herramientas externas necesarias (FZF, AG, Ripgrep) según tu sistema operativo.

4. Abre Neovim y ejecuta `:PlugInstall` o el comando correspondiente para instalar los plugins.

## Configuración adicional

- **Coc.nvim**: Asegúrate de tener las extensiones necesarias para tus lenguajes de programación. Puedes configurar las extensiones dentro de `coc-settings.json`.
- **FZF**: Configura el comando `rg` o `ag` para realizar búsquedas rápidas en tu proyecto.
- **Ripgrep/AG**: Se utilizan como herramientas de búsqueda rápida en lugar de la búsqueda estándar de Neovim.

## Enlaces útiles

- [Neovim](https://neovim.io/)
- [Coc.nvim](https://github.com/neoclide/coc.nvim)
- [FZF](https://github.com/junegunn/fzf)
- [Ripgrep](https://github.com/BurntSushi/ripgrep)
- [AG](https://github.com/ggreer/the_silver_searcher)


## Adicionales:

- pip install json5
- pip install pynvim
- pip3 install neovim

- :CocInstall https://github.com/rafamadriz/friendly-snippets@main

## INSTALL LINTER AND FIXER PHP
composer global require friendsofphp/php-cs-fixer
