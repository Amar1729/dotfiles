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
        ["<C-u>"] = map(map.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = map(map.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = map(map.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = map({
            i = map.abort(),
            c = map.close(),
        }),
        ["<Tab>"] = map.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

        ["<C-j>"] = map(function (fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s", "c" }),

        ["<C-h>"] = map(function (fallback)
            if luasnip.jumpable(-1) then
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

-- triggered by input() (e.g. LSP renames, conditional breakpoints, etc)
cmp.setup.cmdline("@", {
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
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

-- mute diagnostics by default, too noisy
vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
})
