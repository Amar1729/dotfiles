vim.opt.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require'cmp'
local feedkeys = require'cmp.utils.feedkeys'

local t = function (str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- annotate completion candidates in Pmenu (vscode-like)
-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- had to install nerd-fonts-patched FantasqueSansMono to get this to work:
-- https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono
local kind_icons = {
  Text = '  ',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '  ',
  Variable = '  ',
  Class = '  ',
  Interface = '  ',
  Module = '  ',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '  ',
  Snippet = '  ',
  Color = '  ',
  File = '  ',
  Reference = '  ',
  Folder = '  ',
  EnumMember = '  ',
  Constant = '  ',
  Struct = '  ',
  Event = '  ',
  Operator = '  ',
  TypeParameter = '  ',
}

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- cmp.mapping.preset.{insert,cmdline} sets some default bindings.
  -- see: https://github.com/hrsh7th/nvim-cmp/issues/231#issuecomment-1098175017
  -- and: https://github.com/hrsh7th/nvim-cmp/commit/93cf84f7deb2bdb640ffbb1d2f8d6d412a7aa558
  -- TODO - in light of this removal, this bindings could probably be cleaned up in the future.
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    -- snippet movement with vsnips (should i upgrade to luasnip?)
    ['<C-j>'] = cmp.mapping(function (fallback)
        if vim.fn['vsnip#jumpable'](1) == 1 then
            feedkeys.call(t"<Plug>(vsnip-jump-next)", "")
        else
            fallback()
        end
    end, { 'i', 's', 'c' }),

    ['<C-h>'] = cmp.mapping(function (fallback)
        if vim.fn['vsnip#jumpable'](-1) == 1 then
            feedkeys.call(t"<Plug>(vsnip-jump-prev)", "")
        else
            fallback()
        end
    end, { 'i', 's', 'c' }),

  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      -- Concatenate the icons with the name of the item kind
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        vsnip = "[vsnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  },
  mapping = cmp.mapping.preset.cmdline({}),
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  mapping = cmp.mapping.preset.cmdline({}),
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- mute diagnostics by default, too noisy
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- restrain a language server (in the case that i'm using multiple for same language)
local on_attach_restrained = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
    client.server_capabilities.signatureHelpProvider = false
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    -- bash
    'bashls',
    -- python
        -- needs custom flags
    -- 'pylsp',
    -- 'pyright',
    'jedi_language_server',
    -- ruby
    'solargraph',
    -- lua
    'sumneko_lua',
    -- java
        -- needs custom flags
    -- 'java_language_server',
    -- c/c++
        -- ccls/clangd both rely on JSON compilation databases
        -- requires running `bear -- <build cmd>` first
    -- 'ccls',
    'clangd',
    -- rust
    'rust_analyzer',
    -- go
    'gopls',
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
lspconfig['pyright'].setup({
    -- disable several capabilities in favor of jedi_language_server
    on_attach = on_attach_restrained,
})

lspconfig['pylsp'].setup({
    enable = true,
    -- disable several capabilities in favor of jedi_language_server
    on_attach = on_attach_restrained,
    settings = {
        pylsp = {
            configurationSources = { "flake8", "mypy" },
            plugins = {
                flake8 = { enabled = true },
                mypy = { enabled = true },
            },
        },
    },
})

-- java
lspconfig.java_language_server.setup {
    on_attach = on_attach,
    cmd = { os.getenv("HOME") .. "/.cache/java-language-server/dist/lang_server_mac.sh" },
}
