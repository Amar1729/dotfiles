-- required for nvim-cmp
vim.opt.completeopt = "menu,menuone,noselect"

-- Setup nvim-cmp.
local cmp = require("cmp")
local map = cmp.mapping
local luasnip = require("luasnip")

local t = function (str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- defined by nvim-cmp's example mappings for luasnip
-- i don't really understand the point of this function
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- annotate completion candidates in Pmenu (vscode-like)
-- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-codicons-to-the-menu
-- had to install nerd-fonts-patched FantasqueSansMono to get this to work:
-- https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FantasqueSansMono
local kind_icons = {
    Text = "  ",
    Method = "  ",
    Function = "  ",
    Constructor = "  ",
    Field = "  ",
    Variable = "  ",
    Class = "  ",
    Interface = "  ",
    Module = "  ",
    Property = "  ",
    Unit = "  ",
    Value = "  ",
    Enum = "  ",
    Keyword = "  ",
    Snippet = "  ",
    Color = "  ",
    File = "  ",
    Reference = "  ",
    Folder = "  ",
    EnumMember = "  ",
    Constant = "  ",
    Struct = "  ",
    Event = "  ",
    Operator = "  ",
    TypeParameter = "  ",
    DataBase = "  ",
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- cmp.mapping.preset.{insert,cmdline} sets some default bindings.
    -- see: https://github.com/hrsh7th/nvim-cmp/issues/231#issuecomment-1098175017
    -- and: https://github.com/hrsh7th/nvim-cmp/commit/93cf84f7deb2bdb640ffbb1d2f8d6d412a7aa558
    -- TODO - in light of this removal, this bindings could probably be cleaned up in the future.
    mapping = map.preset.insert({
        ["<C-b>"] = map(map.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = map(map.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = map(map.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = map({
            i = map.abort(),
            c = map.close(),
        }),
        ["<CR>"] = map.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ["<C-j>"] = map(function (fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s", "c" }),

        ["<C-h>"] = map(function (fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", "c" }),

    }),

    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lsp", keyword_length = 3 },
        { name = "buffer", keyword_length = 3 },
        { name = "luasnip", keyword_length = 2 },
    }),

    formatting = {
        format = function(entry, vim_item)
            local kind_menu = {
                path = "[Path]",
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[luasnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[LaTeX]",
            }

            -- README says it marks completion items, but it's not showing up for me
            kind_menu["vim-dadbod-completion"] = "[DB]"

            if entry.source.name == "vim-dadbod-completion" then
                vim_item.kind = "DataBase"
            end

            -- Kind icons
            -- Concatenate the icons with the name of the item kind
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
            -- Source
            vim_item.menu = kind_menu[entry.source.name]
            return vim_item
        end
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" }
    },
    mapping = map.preset.cmdline({}),
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" }
    }, {
        { name = "cmdline" }
    }),
    mapping = map.preset.cmdline({}),
})

-- Ensure we still have buffer completion in SQL files opened without DBUI
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        cmp.setup.buffer({
            sources = {
                { name = "vim-dadbod-completion" },
                { name = "buffer" },
                { name = "luasnip" },
            }
        })
    end,
})

-- Setup lspconfig.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

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
    buf_keymap("n", "gr", vim.lsp.buf.references)
    buf_keymap("n", "<space>f", function() vim.lsp.buf.format { async = true } end)
end

-- restrain a language server (in the case that i"m using multiple for same language)
local on_attach_restrained = function(client, buffer)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.hoverProvider = false
    client.server_capabilities.renameProvider = false
    client.server_capabilities.signatureHelpProvider = false
end

-- assign border -> border_chars
-- override all floating windows with our new explicitly-defined border
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

-- load neodev only if editing lua/lua.tmpl files under nvim/chezmoi/packer root
local has_lsp_config, neodev = pcall(require, "neodev")
if has_lsp_config then
    neodev.setup({
        override = function(root_dir, library)
            local util = require("neodev.util")
            if (
                util.has_file(root_dir, ".local/share/chezmoi/")
                or
                util.has_file(root_dir, "pack/packer")
                -- neodev will implicitly set up for nvim config dir:
                -- or
                -- util.is_nvim_config()
            ) then
                library.enabled = true
                library.plugins = true
            end
        end,
    })
end

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
    "lua_ls",
    -- java
        -- needs custom flags
        -- "java_language_server",
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

-- java
lspconfig.java_language_server.setup {
    on_attach = on_attach,
    -- TODO - should this line be templated/checked for which OS?
    cmd = { os.getenv("HOME") .. "/.cache/java-language-server/dist/lang_server_mac.sh" },
}
