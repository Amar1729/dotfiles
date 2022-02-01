neomake settings
let g:neomake_python_enabled_makers = ['flake8', 'mypy', 'vulture']

if executable('pyright')
    call add(g:neomake_python_enabled_makers, 'pyright')
endif

let g:neomake_python_pyright_maker = {
    \ 'exe': 'pyright',
    \ 'errorformat':
        \ '%E%f:%l:%c - error: %m,' .
        \ '%W%f:%l:%c - warning: %m,' .
        \ '%I%f:%l:%c - information: %m,' .
        \ '%-G%.%#',
    \ }

" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)

" red
hi NeomakeErrorSign ctermfg=1
" white
hi NeomakeWarningSign ctermfg=7
" blue (?)
hi NeomakeMessageSign ctermfg=4
" green (?)
hi NeomakeInfoSign ctermfg=2

let g:neomake_error_sign =   {'text' : 'x', 'texthl' : 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text' : '!', 'texthl' : 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text' : '>', 'texthl' : 'NeomakeMessageSign'}
let g:neomake_info_sign =    {'text' : 'i', 'texthl' : 'NeomakeInfoSign'}
