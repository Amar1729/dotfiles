-- vim.cmd.colorscheme("gruvbox")
vim.cmd.colorscheme("wal")

-- from old dein plugins file (do i still want these settings?):
-- set nocompatible
-- filetype plugin on

local options = {
    g = {
        -- vim-dadbod-ui
        db_ui_tmp_query_location = '~/.cache/nvim/queries/',
    },

    opt = {
        relativenumber = true,
        number = true,

        expandtab = true,
        tabstop = 4,
        softtabstop = 4,
        shiftwidth = 4,

        -- allow mouse control
        mouse = "a",

        -- case-insensitive, smart search for /, ?
        ignorecase = true,
        smartcase = true,

        -- hide modified buffers (allow opening of new buffers if current is edited)
        hidden = true,

        -- autoread changes made outside vim
        autoread = true,

        -- persistent undo!
        undofile = true,

        -- spell check
        -- treesitter is used to only spell-check comments/strings
        spell = true,
        spelllang = "en_us",

        splitbelow = true,
        splitright = true,

        -- identify cursor line number visually
        -- cursorlineopt=both (line and number) is too much
        cursorline = true,
        cursorlineopt = "number",

        -- use system clipboard for + / * registers
        -- see autocmds for how clipboard is actually managed.
        -- clipboard = "unnamedplus",

        -- use conceal.nvim to hide keywords
        conceallevel = 2,
    },
}


-- LSP Diagnostics - better signs
local signs = {
    DiagnosticSignError = "x",
    DiagnosticSignWarn = "!",
    DiagnosticSignInfo = ">",
    DiagnosticSignHint = "?",
}

for name, icon in pairs(signs) do
    vim.fn.sign_define(name, { text = icon, texthl = name })
end


--- Set vim options with a nested table like API with the format vim.<first_key>.<second_key>.<value>
-- @param options the nested table of vim options
for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
