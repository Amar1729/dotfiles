local M = {}

-- only map the following keys after LSP attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function (ev)
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { noremap=true, silent=true, buffer=ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)

    -- built-in LSP / telescope / glance ?
    vim.keymap.set("n", "gr", vim.lsp.buf.references)

    vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)

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
