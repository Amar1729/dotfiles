" -*- vim -*-
" -- filetype settings:
"  java


" echodoc
" -- show documentation for completed functions in cmdline
set cmdheight=2
" id like to use nvim floating window but javacomplete2 doesnt want to work in nvim
"let g:echodoc#type = "echo"
let g:echodoc_enable_at_startup = 1


" javacomplete2
" -- completer for java that can read build files like gradle/maven
"autocmd FileType java setlocal omnifunc=javacomplete#Complete
setlocal omnifunc=javacomplete#Complete


" default mappings:
" nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
" nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
" nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
" nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

" recommended fix, doesn't work
"let g:JavaComplete_CheckServerVersionAtStartup = 0
