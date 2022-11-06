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
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'vsnip' , keyword_length = 2 },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- Kind icons
      -- Concatenate the icons with the name of the item kind
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      -- Source
      vim_item.menu = ({
        path = "[Path]",
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
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- mute diagnostics by default, too noisy
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- restrain a language server (in the case that i'm using multiple for same language)
local on_attach_restrained = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
    client.server_capabilities.signatureHelpProvider = false
end

-- link FloatBorder to StatusLine highlight group
-- then:
--   - assign border -> border_chars : FloatBorder highlight group
--   - override all floating windows with our new explicitly-defined border
vim.api.nvim_set_hl(0, "FloatBorder", { link = "StatusLine" } )

local border_chars = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
local border = {}
for i, char in pairs(border_chars) do
    border[i] = { char, "FloatBorder" }
end

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, fp_opts, ...)
  fp_opts = fp_opts or {}
  fp_opts.border = fp_opts.border or border
  return orig_util_open_floating_preview(contents, syntax, fp_opts, ...)
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
    -- 'sumneko_lua',
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

-- lua (primarily for neovim config)
lspconfig['sumneko_lua'].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = { vim.split(package.path, ';') },
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
                maxPreload = 1000,
            },
        }
    }
}
