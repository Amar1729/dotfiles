"""
" Augroups
"""

" save folds in a file, restore when it's opened again
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

" why is this necessary? didn't nvim use to do this automatically?
augroup SetSyntaxColor
  autocmd!
  autocmd BufWinLeave *rc set syntax=config
augroup END

" auto-attempt json prettification
augroup JsonPrettify
  autocmd!
  autocmd BufWinEnter *.json silent! %!python -m json.tool
augroup END

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

" templates for common languages
augroup templates
    autocmd BufNewFile *.py 0r ~/.config/nvim/templates/skeleton.py
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.bash
augroup end

" auto-write changes to chezmoi files
autocmd BufWritePost ~/.local/share/chezmoi/* ! chezmoi apply --source-path "%"
