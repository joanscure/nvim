#!/usr/bin/env bash
# ==============================================================================
# BOOTSTRAP DE MASON (LINUX) - ejecutar UNA VEZ, despues de install.txt
#
# Fuerza la instalacion de los LSP servers y herramientas que Mason
# normalmente auto-instala en el primer arranque de Neovim. Sirve de
# respaldo cuando esa auto-instalacion silenciosa falla (por ejemplo si
# Neovim se abrio antes de que node/npm estuvieran en el PATH de la
# sesion), lo que deja servidores como vtsls o angularls sin instalar
# sin ningun aviso.
#
# Uso:
#   chmod +x bootstrap.sh && ./bootstrap.sh
# ==============================================================================

set -euo pipefail

if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
  echo "node/npm no estan en el PATH de esta sesion. Abre una terminal nueva (o revisa nvm/volta) y vuelve a intentarlo." >&2
  exit 1
fi

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim no esta en el PATH." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Instalando LSP servers via Mason (headless, espera a que terminen)..."
nvim --headless -c "luafile $SCRIPT_DIR/bootstrap.lua"

echo "Instalando herramientas de mason-tool-installer (sync)..."
nvim --headless "+MasonToolsInstallSync" "+qa"

echo "Listo. Verifica con ':Mason' dentro de Neovim que todo quedo instalado."
echo
echo "Nota Angular: angularls (el binario) queda instalado por Mason, pero para"
echo "que el LSP funcione completo dentro de un proyecto Angular (ir a definicion"
echo "en templates, autocompletado, etc.) el propio proyecto tambien necesita"
echo "'@angular/language-service' como devDependency:"
echo "  npm install --save-dev @angular/language-service"
