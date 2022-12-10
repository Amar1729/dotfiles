-- vim.cmd.colorscheme("gruvbox")
vim.cmd.colorscheme("wal")

-- from old dein plugins file (do i still want these settings?):
-- set nocompatible
-- filetype plugin on

local options = {
    g = {
        mapleader = ",",
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
    },
}


-- LSP Diagnostics - better signs
-- (is there a lua equivalent for `:sign` ?)
vim.cmd [[
sign define DiagnosticSignError text=x
sign define DiagnosticSignWarn text=!
sign define DiagnosticSignInfo text=>
sign define DiagnosticSignHint text=?
]]


--- Set vim options with a nested table like API with the format vim.<first_key>.<second_key>.<value>
-- @param options the nested table of vim options
for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
