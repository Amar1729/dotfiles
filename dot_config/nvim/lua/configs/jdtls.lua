-- note: this file requires my lspconfig_config.on_attach

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("$HOME") .. "/.cache/nvim/jdtls/" .. project_name

-- TODO: maybe glob this for os and arch?
local version = "org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar"
local jdtsl_platform = "mac_arm"

require("jdtls").start_or_attach({
  cmd = {
    -- explicitly using (at least) java 17.
    vim.fn.expand("$HOME") .. "/.sdkman/candidates/java/17.0.6-tem/bin/java",

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- brew --prefix
    "-jar",
    "/opt/homebrew/opt/jdtls/libexec/plugins/" .. version,

    "-configuration",
    "/opt/homebrew/opt/jdtls/libexec/config_" .. jdtsl_platform,

    "-data",
    workspace_dir,
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = vim.fn.expand("$HOME") .. "/.sdkman/candidates/java/11.0.18-tem",
          },
          {
            name = "JavaSE-17",
            path = vim.fn.expand("$HOME") .. "/.sdkman/candidates/java/17.0.6-tem",
          },
        },
      },
    },
  },
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  on_attach = require("configs.lsp.config").on_attach,
})
