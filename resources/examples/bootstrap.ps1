# ==============================================================================
# BOOTSTRAP DE MASON (WINDOWS) - ejecutar UNA VEZ, despues de install.txt
#
# Fuerza la instalacion de los LSP servers y herramientas que Mason
# normalmente auto-instala en el primer arranque de Neovim. Sirve de
# respaldo cuando esa auto-instalacion silenciosa falla (por ejemplo si
# Neovim se abrio antes de que Node/Volta estuvieran en el PATH de la
# sesion), lo que deja servidores como vtsls o angularls sin instalar
# sin ningun aviso.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1
# ==============================================================================

$ErrorActionPreference = "Stop"

$node = Get-Command node -ErrorAction SilentlyContinue
$npm  = Get-Command npm  -ErrorAction SilentlyContinue
if (-not $node -or -not $npm) {
  Write-Error "node/npm no estan en el PATH de esta sesion. Abre una terminal nueva (o reinicia sesion) despues de instalar Volta/Node y vuelve a intentarlo."
  exit 1
}

$nvimCmd = Get-Command nvim -ErrorAction SilentlyContinue
if (-not $nvimCmd) {
  Write-Error "nvim no esta en el PATH."
  exit 1
}

Write-Host "Instalando LSP servers y herramientas via Mason (headless)..."
nvim --headless `
  "+MasonInstall vtsls angularls html cssls jsonls jdtls yamlls eslint marksman prismals pyright" `
  "+MasonToolsInstall" `
  "+qa"

Write-Host "Listo. Verifica con ':Mason' dentro de Neovim que todo quedo instalado."
Write-Host ""
Write-Host "Nota Angular: angularls (el binario) queda instalado por Mason, pero para" -ForegroundColor Yellow
Write-Host "que el LSP funcione completo dentro de un proyecto Angular (ir a definicion" -ForegroundColor Yellow
Write-Host "en templates, autocompletado, etc.) el propio proyecto tambien necesita" -ForegroundColor Yellow
Write-Host "'@angular/language-service' como devDependency:" -ForegroundColor Yellow
Write-Host "  npm install --save-dev @angular/language-service" -ForegroundColor Yellow
