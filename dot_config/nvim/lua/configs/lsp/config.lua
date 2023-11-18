local M = {}

-- only map the following keys after LSP attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function (ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local keymap = function (mode, key, cb, desc)
      local opts = vim.tbl_deep_extend("force", { noremap=true, silent=true, buffer=ev.buf }, { desc = desc })
      vim.keymap.set(mode, key, cb, opts)
    end

    keymap("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
    keymap("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
    keymap("n", "K", vim.lsp.buf.hover, "LSP: Hover documentation")
    keymap("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
    keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "LSP: Add workspace folder")
    keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "LSP: Remove workspace folder")
    keymap("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "LSP: List workspace folders")
    keymap("n", "<space>D", vim.lsp.buf.type_definition, "LSP: Show type definition")
    keymap("n", "<space>rn", vim.lsp.buf.rename, "LSP: Rename symbol")
    keymap("n", "<space>ca", vim.lsp.buf.code_action, "LSP: Code action")

    -- built-in LSP / telescope / glance ?
    keymap("n", "gr", vim.lsp.buf.references, "LSP: Find references")

    keymap("n", "<space>f", function() vim.lsp.buf.format { async = true } end, "LSP: Format")

    -- for lvimuser/lsp-inlayhints.nvim
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    require("lsp-inlayhints").on_attach(client, ev.buf)
  end
})

-- restrain a language server (in the case that i"m using multiple for same language)
function M.on_attach_restrained(client, buffer)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.hoverProvider = false
  client.server_capabilities.renameProvider = false
  client.server_capabilities.signatureHelpProvider = false
end

return M
