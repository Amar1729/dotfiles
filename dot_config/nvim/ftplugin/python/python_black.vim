" -*- vim -*-
" FILE: python_black.vim

" Run black-macchiato on a section of python code
" This tool uses `black`, a code formatter for python, to transform stdin >
" stdout.

vmap <buffer> <leader>l  :!black-macchiato<cr>
