local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
function M.on_attach(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  local buf_keymap = function(m, s, c) vim.keymap.set(m, s, c, bufopts) end

  buf_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "gi", vim.lsp.buf.implementation)
  buf_keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder)
  buf_keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder)
  buf_keymap("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end)
  buf_keymap("n", "<space>D", vim.lsp.buf.type_definition)
  buf_keymap("n", "<space>rn", vim.lsp.buf.rename)
  buf_keymap("n", "<space>ca", vim.lsp.buf.code_action)

  -- built-in LSP / telescope / glance ?
  buf_keymap("n", "gr", vim.lsp.buf.references)

  buf_keymap("n", "<space>f", function() vim.lsp.buf.format { async = true } end)

  -- for lvimuser/lsp-inlayhints.nvim
  require("lsp-inlayhints").on_attach(client, bufnr)
end

-- restrain a language server (in the case that i"m using multiple for same language)
function M.on_attach_restrained(client, buffer)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.hoverProvider = false
  client.server_capabilities.renameProvider = false
  client.server_capabilities.signatureHelpProvider = false
end

return M
