-- note: this file requires my lspconfig_config.on_attach

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("$HOME") .. "/.cache/nvim/jdtls/" .. project_name

-- TODO: maybe glob this for os and arch?
-- see: brew --prefix
local install_path = '/opt/homebrew/opt/jdtls/libexec/'
local jdtls_platform = "mac_arm"

local plugin_path = install_path .. 'plugins'
local config_path = install_path .. 'config_' .. jdtls_platform

-- TODO: make this robust if >1 or 0 matches are found
local jar_path = vim.fs.find(function(name, path)
  return name:match('org.eclipse.equinox.launcher_.*.jar$')
end, {limit = 1, type = 'file', path = plugin_path})[1]

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

    "-jar",
    jar_path,

    "-configuration",
    config_path,

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
