" Vim syntax file
" Language: khdrc syntax file
" Maintainer: mario d'amore
" Latest Revision: 13 Feb 2017

"prevents it from being loaded if syntax highlighting has already been enabled for this buffer
if exists("b:current_syntax")
  finish
endif

syntax region khdComment start="/\*"  end="\*/"
syntax match  khdComment  "\v#.*$"
highlight link khdComment  Comment

syntax keyword khdKeyword khd kwmc
highlight link khdKeyword Keyword

" -- yabai stuff

syntax keyword khdKeyword yabai
highlight link khdKeyword Keyword

syntax match khdKey '[lr]\?cmd'
syntax match khdKey '[lr]\?alt'
syntax match khdKey '[lr]\?ctrl'
syntax match khdKey '[lr]\?shift'
highlight link khdKey Keyword

syntax match khdLiteral '\<[0-9a-zA-Z]\>' contained display
syntax match khdLiteral '\<0x\d\d\>' contained display
syntax keyword khdLiteral return left right up down contained
highlight link khdLiteral Constant

" syntax region khdHotKey start='^\s*[\S]' end='\<:\>' contains=khdKey,khdLiteral
" syntax region khdHotKey start='^' end=' :\>' contains=khdKey,khdLiteral

syntax region khdCommand start='khdHotKey:' end='$'

" --

syntax keyword khdFunction config rule mode reload
highlight link khdFunction Identifier

"syntax keyword khdOperator padding gap tiling float-non-resizable lock-to-container focus-follows-mouse standby-on-float center-on-float mouse-follows-focus mouse-drag cycle-focus space display split-ratio spawn border owner properties name
syntax keyword khdOperator on_enter prefix timeout restore focused color window display query rotate space
highlight link khdOperator Include

let b:current_syntax = "khd"
