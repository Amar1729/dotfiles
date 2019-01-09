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

syntax keyword khdFunction config rule mode reload
highlight link khdFunction Identifier

"syntax keyword khdOperator padding gap tiling float-non-resizable lock-to-container focus-follows-mouse standby-on-float center-on-float mouse-follows-focus mouse-drag cycle-focus space display split-ratio spawn border owner properties name
syntax keyword khdOperator on_enter prefix timeout restore focused color window display query rotate space
highlight link khdOperator Include

let b:current_syntax = "khd"
