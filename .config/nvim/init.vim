" Amar Paul's init.vim (for Neovim)

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/Amar/.config/nvim//repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/Amar/.config/nvim/')
  call dein#begin('/Users/Amar/.config/nvim/')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/Amar/.config/nvim//repos/github.com/Shougo/dein.vim')


  " Themes:

  " gruvbox colorscheme
  call dein#add('morhetz/gruvbox')

  " pywal vim colorscheme
  call dein#add('dylanaraps/wal.vim')

  " powerline that works with neovim
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')


  " Engines, code style:

  " deoplete for nvim
  call dein#add('Shougo/deoplete.nvim')
  "call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-jedi')
  
  " async linting
  "call dein#add('neomake/neomake')


  " Quality of life:

  " git gutter
  call dein#add('airblade/vim-gitgutter')

  " continuous highlighting, better incsearch
  call dein#add('haya14busa/incsearch.vim')

  " for surrounding phrases with characters
  call dein#add('tpope/vim-surround')

  " collab editing
  "call dein#add('FredKSchott/CoVim')

  " nice completion of (x)html tags
  call dein#add('tpope/vim-ragtag')

  " Live LaTeX previewing
  call dein#add('xuhdev/vim-latex-live-preview')

  " Syntax highlighting for coffeescript
  "call dein#add('kchmck/vim-coffee-script')

  " Support for Julia
  "call dein#add('JuliaEditorSupport/julia-vim')

  " (vim plugin) minimap
  "call dein#add('severin-lemaignan/vim-minimap')

  " Live LaTeX previewing
  "call dein#add('xuhdev/vim-latex-live-preview')

  " Different LaTeX live previewing (vllp currently broken for TeXLive2016 ?)
  "call dein#add('donRaphaco/neotex')
  " no, I think this only works for vim?

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
" (Annoying when you're testing lots of different plugins)
if dein#check_install()
  " call dein#install()
endif

"End dein Scripts-------------------------


"""
" Personal Settings
"""

"""
" Look and Feel
"""

colorscheme gruvbox
set background=dark
set number relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4

set mouse=a

" hide modified buffers (allow opening of new buffers if current is edited)
set hidden

" override some defaults (only needed on ubuntu?)
set foldmethod=manual
set foldcolumn=2

" Recolor columns and git symbols
" set transparency when using urxvt fake transparency (ctermbg=NONE)
hi Normal ctermbg=NONE
hi clear FoldColumn
hi FoldColumn ctermbg=NONE
hi Folded cterm=bold ctermbg=NONE ctermfg=7
hi clear SignColumn
" gruvbox: ctermbg=235
hi SignColumn ctermbg=NONE
" linenr: ctermfg=245 for all symbols				  Defaults:
hi GitGutterAdd ctermbg=NONE ctermfg=142			" GruvboxGreenSign fg/bg 142/237
hi GitGutterChange ctermbg=NONE ctermfg=108			" GruvboxAquaSign fg/bg 108/237
hi GitGutterDelete ctermbg=NONE ctermfg=167			" GruvboxRedSign fg/bg 167/237
hi GitGutterChangeDelete ctermbg=NONE ctermfg=108	" GruvboxAquaSign fg/bg 108/237

"""
" Personal definitions
"""

let mapleader=","

" Copy to clipboard (mac uses * register: linux uses + reg)
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from system: clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Paste from system: primary
nnoremap <leader><C-p> "*p
nnoremap <leader><C-P> "*P
vnoremap <leader><C-p> "*p
vnoremap <leader><C-P> "*P

" Buffer movement
nmap <leader>n :bnext<CR>	" Cycle through buffers
nmap <leader>N :bprev<CR>
"nmap <leader>m :bprev<CR>	" use this for tab-switching?
nmap <leader>m :tabn<CR>
nmap <leader>w <C-W><C-W>	" Cycle through splits (in same window)

" clear highlighted matches from find
nmap <leader><Space> :noh<CR>


"""
" Augroups
"""

" auto-reload config
"augroup AutoCommands
"	au!
"    autocmd BufWritePost $MYVIMRC source $MYVIMRC 
"augroup END

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
hi StatusLine cterm=None ctermfg=142 ctermbg=None
set statusline=%t


"""
" Plugin Settings and Keybinds
"""


" deoplete settings
let g:deoplete#enable_at_startup=1
"let g:deoplete#sources#clang#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
" this will chang with each upgrade! symlink?
"let g:deoplete#sources#clang#clang_header='/Library/Developer/CommandLineTools/usr/lib/clang/8.0.0/include'

let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

" close the deoplete preview window on autocomplete
autocmd CompleteDone * pclose

" deoplete tab-complete:
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>" 

" neomake settings
" how to lint with python3?
" let g:neomake_python_pylint_exe = 'python3'

" When writing a buffer, and on normal mode changes (after 750ms).
"call neomake#configure#automake('nw', 750)
"let g:neomake_error_sign =   {'text' : 'x', 'texthl' : 'NeomakeErrorSign'}
"let g:neomake_warning_sign = {'text' : '!', 'texthl' : 'NeomakeWarningSign'}
"let g:neomake_message_sign = {'text' : '>', 'texthl' : 'NeomakeMessageSign'}
"let g:neomake_info_sign =    {'text' : 'i', 'texthl' : 'NeomakeInfoSign'}


" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" TODO chromatica settings
let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1


" vim-minimap settings
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'


""""
" don't know about merging this stuff, don't use latex much anymore?
"
" vim-latex-live-preview
let g:livepreview_previewer = 'evince'
nnoremap <leader>L :LLPStartPreview<CR>
" live previewing currently broken?
"autocmd TextChanged,TextChangedI *tex silent :LLPStartPreview 

" latex live stuff
" update time
autocmd Filetype tex setl updatetime=5
nnoremap <F12> :LLPStartPreview<CR>

" change from default evince
" actually i think evince is fine?
"let g:livepreview_previewer = 'mupdf'

""""

" neotex settings
"let g:neotex_enabled = 0


" airline-vim, airline-vim-themes settings
let g:airline#extensions#branch#enabled = 1

" wip : rename other modes?
let g:airline_mode_map = {
	\ 'n' : 'normie',
	\ 'i' : 'hardcore hacking',
	\ }

function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode','crypt','paste','spell','iminsert'])
	"let g:airline_section_b = airline#section#create(['hunks'])
	let g:airline_section_b = airline#section#create(['%v'])
	let g:airline_section_x = ""
	let g:airline_section_y = "%v"
	let g:airline_section_z = '%l/%L'
	let g:airline_section_error = ''
	let g:airline_section_warning = ''
endfunction
"autocmd VimEnter * call AirlineInit()
let g:airline_section_x = ""
let g:airline_section_y = "%v"
let g:airline_section_z = '%l/%L'
let g:airline_section_error = ''
let g:airline_section_warning = ''

" Patch the font myself
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" some good airline themes:
" dark:
"	badcat, laederon, base16_twilight, bubblegum, distinguished, term
" light:
"	papercolor
let g:airline_theme='term'
let g:airline#extensions#tabline#enabled = 1		" Enable list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'	" Show just filename in bufferline
let g:airline#extensions#tmuxline#enabled = 0		" Don't rewrite my tmux conf!
