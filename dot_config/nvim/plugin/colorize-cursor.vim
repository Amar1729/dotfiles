" Recolor the cursor's line number when you enter/leave insert mode.
"
" Based off of:
" https://stackoverflow.com/questions/15561132/run-command-when-vim-enters-visual-mode

" as of nvim (version?), requires cursorline and at least cursorlineopt=number

" guifg lines are disabled, since my current colorscheme only uses termcolors

function! ReturnHighlightTerm(group, term)
   " Store output of group to variable
   let l:output = execute('hi ' . a:group)

   " Find the term we're looking for
   return matchstr(output, a:term.'=\zs\S*')
endfunction

function! CursorLineNrColorInsert(mode)
    " Insert mode: blue
    if a:mode == "i"
        highlight CursorLineNr ctermfg=1
        " highlight CursorLineNr guifg=#268bd2

    " Replace mode: red
    elseif a:mode == "r"
        highlight CursorLineNr ctermfg=4
        " highlight CursorLineNr guifg=#dc322f

    else
        highlight CursorLineNr ctermfg=0
        " highlight CursorLineNr guifg=#073642

    endif
endfunction

let s:backup_term = ReturnHighlightTerm("CursorLineNr", "ctermfg")
" let s:backup_gui = ReturnHighlightTerm("CursorLineNr", "guifg")

augroup colorize_cursor
    autocmd!
    autocmd InsertEnter * call CursorLineNrColorInsert(v:insertmode)
    autocmd InsertLeave * :execute "highlight CursorLineNr ctermfg=" . s:backup_term
    " autocmd InsertLeave * :execute "highlight CursorLineNr guifg=" . s:backup_gui
augroup END
