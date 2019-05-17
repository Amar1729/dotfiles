" better .vimrc
" no plugins for low-pkg systems

" Spin up default plugins if you don't install neovim
"call plug#begin('~/.vim/plugged')
"
"Plug 'tpope/vim-sensible'
"Plug 'morhetz/gruvbox'
"Plug 'davidhalter/jedi-vim'
"
"call plug#end()

"colorscheme zenburn
"colorscheme gruvbox

" need this shit
set modeline
set laststatus=2
set statusline=%{mode()}\ %f

syntax on

set number
"set relativenumber

set autoindent noexpandtab tabstop=4 shiftwidth=4
set incsearch hlsearch
set ignorecase smartcase

set mouse=a

augroup remember_folds
	autocmd!
	autocmd BufWinLeave *.* mkview
	autocmd BufWinEnter *.* silent! loadview
augroup END

let mapleader = ","

map <Leader>n :bnext<Enter>
map <Leader><Space> :noh<Enter>
