-- ==============================================================================
-- BOOTSTRAP DE MASON (LSP servers) - llamado por bootstrap.ps1 / bootstrap.sh
--
-- :MasonInstall es asincrono: dispara la descarga y devuelve el control de
-- inmediato. Si el script que lo invoca hace "+qa" justo despues, Neovim se
-- cierra antes de que la instalacion termine y el paquete queda a medias
-- (o directamente sin `mason/bin`), sin ningun error visible. Este script
-- espera con vim.wait a que cada paquete termine antes de cerrar Neovim.
-- ==============================================================================

-- Nombres de servidor al estilo lspconfig (los mismos que usamos en lsp.lua).
-- El nombre del paquete de Mason no siempre coincide (p.ej. "cssls" en
-- lspconfig es el paquete "css-lsp" en Mason), asi que se traducen abajo
-- con el mapeo oficial de mason-lspconfig.
local lspconfig_names = {
  "vtsls", "angularls", "html", "cssls", "jsonls",
  "jdtls", "yamlls", "eslint", "marksman", "prismals", "pyright",
  "intelephense", "dockerls", "docker_compose_language_service",
}

local registry = require("mason-registry")

registry.refresh(function()
  -- Se calcula aqui adentro (no antes de refresh) porque este mapeo lee
  -- specs cacheados del registro; en una instalacion nueva ese cache no
  -- existe todavia hasta que termina el refresh, y calcularlo antes deja
  -- el mapeo vacio (cada nombre se traduce a si mismo, lo cual rompe
  -- angularls -> angular-language-server, cssls -> css-lsp, etc).
  local lspconfig_to_package = require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package

  local pending = 0

  local function on_done(name)
    return function(success, err)
      pending = pending - 1
      if success then
        print(("[bootstrap] %s: OK"):format(name))
      else
        print(("[bootstrap] %s: FALLO -> %s"):format(name, tostring(err)))
      end
    end
  end

  for _, lsp_name in ipairs(lspconfig_names) do
    local pkg_name = lspconfig_to_package[lsp_name] or lsp_name
    local ok, pkg = pcall(registry.get_package, pkg_name)
    if not ok then
      print(("[bootstrap] paquete desconocido: %s (mapeado a %s)"):format(lsp_name, pkg_name))
    elseif pkg:is_installed() then
      print(("[bootstrap] %s ya estaba instalado"):format(pkg_name))
    else
      pending = pending + 1
      pkg:install({}, on_done(pkg_name))
    end
  end

  local finished = vim.wait(10 * 60 * 1000, function()
    return pending <= 0
  end, 200)

  if not finished then
    print("[bootstrap] tiempo de espera agotado (10 min); alguna instalacion pudo quedar pendiente")
  end

  vim.schedule(function()
    vim.cmd("qa!")
  end)
end)
