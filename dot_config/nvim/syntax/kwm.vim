" Vim syntax file
" Language: kwmrc syntax file
" Maintainer: mario d'amore
" Latest Revision: 13 Feb 2017

"prevents it from being loaded if syntax highlighting has already been enabled for this buffer
if exists("b:current_syntax")
  finish
endif

syntax region kwmComment start="/\*"  end="\*/"
syntax match  kwmComment  "\v#.*$"
highlight link kwmComment  Comment

syntax keyword kwmKeyword kwmc
highlight link kwmKeyword Keyword

syntax keyword kwmFunction config rule
highlight link kwmFunction Identifier

syntax keyword kwmOperator padding gap tiling float-non-resizable lock-to-container focus-follows-mouse standby-on-float center-on-float mouse-follows-focus mouse-drag cycle-focus space display split-ratio spawn border owner properties name
highlight link kwmOperator Include

let b:current_syntax = "kwm"
