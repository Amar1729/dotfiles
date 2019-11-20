" change colors of chunkwm border when entering/leaving insert mode

" white "0xffebdbb2"
" red "0xccd75f5f"
" green "0xcc98971a"

let s:color_wht = "0xffebdbb2"
let s:color_red = "0xccd75f5f"

let s:os_type = system("uname -s")

function ColorizeBorder()
    if s:os_type =~ "Darwin"
        silent! execute("!chunkc border::color " . s:color_red)
    else
        echom "not implemented for Linux"
    endif
endfunction

function UnColorizeBorder()
    if s:os_type =~ "Darwin"
        silent! execute("!chunkc border::color " . s:color_wht)
    else
        echom "not implemented for Linux"
    endif
endfunction

augroup change_borders
  autocmd!
  autocmd InsertEnter * :call ColorizeBorder()
  autocmd InsertLeave * :call UnColorizeBorder()
  " autocmd VimLeave * :silent! execute "!chunkc border::color 0xffebdbb2"
augroup END
