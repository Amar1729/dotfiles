" Color settings for nvim-cmp completion menu items
" (~ wip) some of these aren't done yet / need to be tested in a larger
" program

highlight CmpItemAbbrDeprecated cterm=strikethrough ctermfg=7

highlight CmpItemAbbrMatch ctermfg=9
highlight CmpItemAbbrMatchFuzzy ctermfg=9

highlight link CmpItemKindFile Constant
highlight link CmpItemKindFolder Constant

highlight link CmpItemKindValue Number

highlight link CmpItemKindConstant Constant
highlight link CmpItemKindKeyword Keyword
highlight link CmpItemKindProperty Keyword
highlight link CmpItemKindOperator TSOperator

highlight link CmpItemKindClass Type
highlight link CmpItemKindModule Type
highlight link CmpItemKindStruct Type

highlight link CmpItemKindEnum Structure
highlight CmpItemKindEnumMember ctermfg=1

" link: Identifier but not bold
highlight CmpItemKindFunction ctermfg=1
highlight CmpItemKindMethod ctermfg=1
highlight CmpItemKindConstructor ctermfg=1
highlight CmpItemKindField ctermfg=1

highlight link CmpItemKindVariable String
highlight link CmpItemKindInterface String
highlight link CmpItemKindText String

highlight link CmpItemKindTypeParameter Label

" what this?
highlight CmpItemKindUnit ctermfg=15

" highlight link CmpItemKindSnippet
" highlight link CmpItemKindColor
" highlight link CmpItemKindReference
" highlight link CmpItemKindEvent
