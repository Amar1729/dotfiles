" change colors of window border when entering/leaving insert mode
" generally requires interaction with window manager + support for colored
" window borders

" white "0xffebdbb2"
" red "0xccd75f5f"
" green "0xcc98971a"

let s:color_wht = "0xffebdbb2"
let s:color_red = "0xccd75f5f"

let s:os_type = system("uname -s")

" yabai, on darwin
let s:cmd = "yabai -m config active_window_border_color"

" TODO: bspwm, on linux

function ColorizeBorder()
    if s:os_type =~ "Darwin"
        silent! execute("!" . s:cmd . " " . s:color_red)
    else
        echom "not implemented for Linux"
    endif
endfunction

function UnColorizeBorder()
    if s:os_type =~ "Darwin"
        silent! execute("!" . s:cmd . " " . s:color_wht)
    else
        echom "not implemented for Linux"
    endif
endfunction

augroup change_borders
  autocmd!
  autocmd InsertEnter * :call ColorizeBorder()
  autocmd InsertLeave * :call UnColorizeBorder()
augroup END
