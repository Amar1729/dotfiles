local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local lspconfig_config = require("configs.lsp.config")
local on_attach = lspconfig_config.on_attach
local on_attach_restrained = lspconfig_config.on_attach_restrained

local M = {}

function M.setup()

  -- Use a loop to conveniently call "setup" on multiple servers and
  -- map buffer local keybindings when the language server attaches
  local servers = {
    -- bash
    "bashls",
    -- python
    -- needs custom flags
    -- "pylsp",
    -- "pyright",
    -- ruby
    "solargraph",
    -- lua
    -- "lua_ls",
    -- java
    -- needs custom flags
    -- "java_language_server",
    -- use nvim-jdtls plugin for java support instead
    -- "jdtls",
    -- c/c++
    -- ccls/clangd both rely on JSON compilation databases
    -- requires running `bear -- <build cmd>` first
    -- "ccls",
    "clangd",
    -- rust
    "rust_analyzer",
    -- go
    "gopls",
  }
  for _, lsp in pairs(servers) do
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      flags = {
        -- This will be the default in neovim 0.7+
        debounce_text_changes = 150,
      },
    }
  end

  -- python
  lspconfig["pyright"].setup({
    -- disable several capabilities in favor of pylsp
    on_attach = on_attach_restrained,
    capabilities = capabilities,
  })

  -- lua
  -- should be mostly configured by lazydev.nvim plugin.
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        hint = {
          enable = true,
          setType = true,
        },
        telemetry = { enable = false },
      },
    },
  })

  lspconfig["pylsp"].setup({
    enable = true,
    on_attach = on_attach,
    settings = {
      pylsp = {
        configurationSources = { "ruff", "mypy" },
        plugins = {
          ruff = { enabled = true },
          mypy = { enabled = true },
        },
      },
    },
  })
end

return M
