" change colors of chunkwm border when entering/leaving insert mode

" white "0xffebdbb2"
" red "0xccd75f5f"
" green "0xcc98971a"

" let g:BORDER_OS_NAME = system("uname -s")

augroup change_borders
  autocmd!
  autocmd InsertEnter * :silent! execute "!chunkc border::color 0xccd75f5f"
  autocmd InsertLeave * :silent! execute "!chunkc border::color 0xffebdbb2"
  " autocmd VimLeave * :silent! execute "!chunkc border::color 0xffebdbb2"
augroup END
