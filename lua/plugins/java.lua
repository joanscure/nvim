-- Java development support via nvim-jdtls
-- Optimized for Spring Boot / WebFlux development
-- Requires: JDK 17+ installed and JAVA_HOME set
return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local jdtls = require("jdtls")

      -- Mason paths
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
      local jdtls_path = mason_path .. "/jdtls"

      -- Check if jdtls is installed
      if vim.fn.isdirectory(jdtls_path) == 0 then
        vim.notify("jdtls not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
        return
      end

      -- Use jdtls wrapper (handles Java args automatically)
      local jdtls_bin = jdtls_path .. "/bin/jdtls"
      if vim.fn.has("win32") == 1 then
        -- On Windows, use the Python wrapper via cmd
        jdtls_bin = vim.fn.stdpath("data") .. "/mason/bin/jdtls.cmd"
      end

      if vim.fn.executable(jdtls_bin) == 0 then
        vim.notify("jdtls binary not found: " .. jdtls_bin, vim.log.levels.ERROR)
        return
      end

      -- Workspace directory (unique per project)
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

      -- Ensure workspace directory exists
      vim.fn.mkdir(workspace_dir, "p")

      -- Lombok support
      local lombok_jar = jdtls_path .. "/lombok.jar"

      -- Debug/Test bundles (optional)
      local bundles = {}
      local java_debug_path = mason_path .. "/java-debug-adapter"
      local java_test_path = mason_path .. "/java-test"

      if vim.fn.isdirectory(java_debug_path) == 1 then
        local debug_bundle = vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
        if debug_bundle ~= "" then table.insert(bundles, debug_bundle) end
      end
      if vim.fn.isdirectory(java_test_path) == 1 then
        local jars = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true)
        if jars ~= "" then
          for _, jar in ipairs(vim.split(jars, "\n")) do
            if jar ~= "" then table.insert(bundles, jar) end
          end
        end
      end

      -- Capabilities from blink.cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        capabilities = blink.get_lsp_capabilities(capabilities)
      end

      -- Extended capabilities for jdtls
      local extendedClientCapabilities = jdtls.extendedClientCapabilities
      extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

      -- Build command using the wrapper
      local cmd = { jdtls_bin }

      -- Add lombok if available
      if vim.fn.filereadable(lombok_jar) == 1 then
        vim.list_extend(cmd, { "--jvm-arg=-javaagent:" .. lombok_jar })
      end

      -- Add workspace data directory
      vim.list_extend(cmd, { "-data", workspace_dir })

      local config = {
        cmd = cmd,
        root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }) or vim.fn.getcwd(),
        capabilities = capabilities,
        settings = {
          java = {
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true, updateSnapshots = true },
            gradle = { enabled = true, wrapper = { enabled = true } },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            references = { includeDecompiledSources = true },
            inlayHints = { parameterNames = { enabled = "all" } },
            format = { enabled = false }, -- Use conform.nvim
            signatureHelp = { enabled = true, description = { enabled = true } },
            contentProvider = { preferred = "fernflower" },
            completion = {
              favoriteStaticMembers = {
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.mockito.Mockito.*",
                "org.mockito.BDDMockito.*",
                "org.mockito.ArgumentMatchers.*",
                "org.assertj.core.api.Assertions.*",
                "org.hamcrest.Matchers.*",
                "org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*",
                "org.springframework.test.web.servlet.result.MockMvcResultMatchers.*",
                "org.springframework.test.web.reactive.server.WebTestClient.*",
                "reactor.test.StepVerifier.*",
              },
              importOrder = { "#", "java", "javax", "jakarta", "org.springframework", "org", "com", "" },
              filteredTypes = { "com.sun.*", "io.micrometer.shaded.*", "java.awt.*", "jdk.*", "sun.*" },
            },
            sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
            codeGeneration = {
              toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
              hashCodeEquals = { useJava7Objects = true, useInstanceof = true },
              useBlocks = true,
            },
          },
        },
        init_options = {
          bundles = bundles,
          extendedClientCapabilities = extendedClientCapabilities,
        },
        on_attach = function(_, bufnr)
          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "Java: " .. desc })
          end

          map("n", "gd", vim.lsp.buf.definition, "Definición")
          map("n", "gr", vim.lsp.buf.references, "Referencias")
          map("n", "gi", vim.lsp.buf.implementation, "Implementaciones")
          map("n", "K", vim.lsp.buf.hover, "Hover")
          map("n", "<leader>rn", vim.lsp.buf.rename, "Renombrar")
          map("n", "<leader>ca", function()
            local fzf_ok, fzf = pcall(require, "fzf-lua")
            if fzf_ok then fzf.lsp_code_actions() else vim.lsp.buf.code_action() end
          end, "Code Action")
          map("n", "[d", vim.diagnostic.goto_prev, "Prev diag")
          map("n", "]d", vim.diagnostic.goto_next, "Next diag")

          map("n", "<leader>jo", jdtls.organize_imports, "Organizar imports")
          map("n", "<leader>jv", jdtls.extract_variable, "Extraer variable")
          map("v", "<leader>jv", function() jdtls.extract_variable(true) end, "Extraer variable")
          map("n", "<leader>jc", jdtls.extract_constant, "Extraer constante")
          map("v", "<leader>jc", function() jdtls.extract_constant(true) end, "Extraer constante")
          map("v", "<leader>jm", function() jdtls.extract_method(true) end, "Extraer método")
          map("n", "<leader>jt", jdtls.test_nearest_method, "Test método cercano")
          map("n", "<leader>jT", jdtls.test_class, "Test clase")
        end,
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          jdtls.start_or_attach(config)
        end,
      })
    end,
  },
}
