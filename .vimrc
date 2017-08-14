

"call plug#begin('~/.vim/plugged')
"
"Plug 'tpope/vim-sensible'
"Plug 'morhetz/gruvbox'
"
"Plug 'davidhalter/jedi-vim'
"
"call plug#end()


augroup remember_folds
	autocmd!
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent! loadview
augroup END

let mapleader = ","

"colorscheme gruvbox
set autoindent noexpandtab tabstop=4 shiftwidth=4
set hlsearch
set relativenumber
set number


map <Leader>n :bnext<Enter>
map <Leader><Space> :noh<Enter>

:inoremap <S-Tab> <C-V><Tab>
