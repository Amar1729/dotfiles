"""
" Augroups
"""

" Deal with status bar (necessary?)

" Cycle status line on command Shift+H
" From http://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom
" 0 : airline on (default)
" 1 : airline off, statusline on 
" 2 : everything hidden
"let s:cycle = 0
let s:cycle = get(s:, 'cycle', 0)
function! CycleHiddenAll()
	if s:cycle == 0
		let s:cycle = 1
		:AirlineToggle
	elseif s:cycle == 1
		let s:cycle = 2
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:cycle = 0
		:AirlineToggle
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction

nnoremap <S-h> :call CycleHiddenAll()<CR>

" for the almost-quiet statusbar
" want the bar itself to be transparent and text to be green.
hi StatusLine cterm=None ctermfg=1 ctermbg=None
set statusline=%t
