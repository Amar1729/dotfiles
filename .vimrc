" Amar's (simple) .vimrc

" Spin up default plugins if you don't install neovim
"call plug#begin('~/.vim/plugged')
"
"	Plug 'tpope/vim-sensible'
"	Plug 'morhetz/gruvbox'
"	Plug 'davidhalter/jedi-vim'

 	"Plug 'FredKSchott/CoVim'
	Plug('dylanaraps/wal.vim')

"call plug#end()

"colorscheme zenburn
"colorscheme gruvbox
colorscheme wal

syntax on

set relativenumber number

set autoindent noexpandtab tabstop=4 shiftwidth=4
set incsearch hlsearch

set mouse=a

augroup remember_folds
	autocmd!
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent! loadview
augroup END

let mapleader = ","

map <Leader>n :bnext<Enter>
map <Leader><Space> :noh<Enter>
