local highlight = function(name, val)
    vim.api.nvim_set_hl(0, name, val)
end

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Vanilla highlights
-- ---- ---- ---- ---- ---- ---- ---- ----

-- for almost-quiet statusbar
-- clear out the status line so it's not gray when we e.g. run a cmd with multi-line output
highlight("StatusLine",                  { ctermfg = 1 })

-- see plugin/colorize-border.vim for augroups that recolor CursorLineNr on
-- insert enter/leave
highlight("CursorLineNr",               { ctermfg = "white" })

highlight("Pmenu",                      { ctermbg = "black" })
-- " switch these two around
highlight("PmenuSbar",                  { ctermfg = 8, ctermbg = 8, bg = "white" })
highlight("PmenuThumb",                 { ctermfg = 7, ctermbg = 7, bg = "grey" })

-- ---- ---- ---- ---- ---- ---- ---- ----
-- ---- Plugin-provided highlights
-- ---- ---- ---- ---- ---- ---- ---- ----

-- nvim-treesitter
-- wal colorscheme: https://github.com/dylanaraps/wal.vim/pull/34/files
highlight("TSInclude",                  { ctermbg = "NONE", ctermfg = 5 })
highlight("TSNamespace",                { ctermbg = "NONE", ctermfg = 4 })
highlight("TSRepeat",                   { ctermbg = "NONE", ctermfg = 5 })
highlight("TSOperator",                 { ctermbg = "NONE", ctermfg = 4 })

-- border color for any (mostly LSP) floating windows
highlight("FloatBorder",                { link = "String" })

-- nvim-cmp
-- Color settings for nvim-cmp completion menu items

highlight("CmpItemAbbrDeprecated",      { strikethrough = true, ctermfg = 7 })

highlight("CmpItemAbbrMatch",           { ctermfg = 9 })
highlight("CmpItemAbbrMatchFuzzy",      { ctermfg = 9 })

highlight("CmpItemKindFile",            { link = "Constant" })
highlight("CmpItemKindFolder",          { link = "Constant" })
highlight("CmpItemKindValue",           { link = "Number" })

highlight("CmpItemKindConstant",        { link = "Constant" })
highlight("CmpItemKindKeyword",         { link = "Keyword" })
highlight("CmpItemKindProperty",        { link = "Keyword" })
highlight("CmpItemKindOperator",        { link = "TSOperator" })

highlight("CmpItemKindClass",           { link = "Type" })
highlight("CmpItemKindModule",          { link = "Type" })
highlight("CmpItemKindStruct",          { link = "Type" })

highlight("CmpItemKindEnum",            { link = "Structure" })
highlight("CmpItemKindEnumMember",      { ctermfg = 1 })

-- link: Identifier but not bold
highlight("CmpItemKindFunction",        { ctermfg = 1 })
highlight("CmpItemKindMethod",          { ctermfg = 1 })
highlight("CmpItemKindConstructor",     { ctermfg = 1 })
highlight("CmpItemKindField",           { ctermfg = 1 })

highlight("CmpItemKindVariable",        { link = "String" })
highlight("CmpItemKindInterface",       { link = "String" })
highlight("CmpItemKindText",            { link = "String" })

highlight("CmpItemKindTypeParameter",   { link = "Label" })

-- what this?
highlight("CmpItemKindUnit",            { ctermfg = 15 })

-- TODO?
-- highlight link CmpItemKindSnippet
-- highlight link CmpItemKindColor
-- highlight link CmpItemKindReference
-- highlight link CmpItemKindEvent

-- colorful-winsep
highlight("NvimSeparator",              { ctermfg = 2 })

-- gitsigns
-- make a changed line more obvious when diagnostics are on that line
-- (this changes the line number color of the line)
highlight("GitSignsChangeNr",           { ctermfg = "white" })
highlight("GitSignsCurrentLineBlame",   { link = "String" })

-- leap
highlight("LeapBackdrop",               { link = "Comment" })
highlight("LeapLabelPrimary",           { ctermfg = "white", ctermbg = "black" })
highlight("LeapLabelSecondary",         { ctermfg = "Red", ctermbg = "white" })
