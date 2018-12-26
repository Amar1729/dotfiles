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
  call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('racer-rust/vim-racer')
  
  " async linting
  call dein#add('neomake/neomake')

  " code snippet engine
  call dein#add('SirVer/ultisnips')

  " snippets are separated from the engine
  call dein#add('honza/vim-snippets')


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

  " (vim plugin) minimap
  call dein#add('severin-lemaignan/vim-minimap')

  " vimwiki
  call dein#add('vimwiki/vimwiki')

  " fzf support
  call dein#add('/usr/local/opt/fzf')
  call dein#add('junegunn/fzf.vim')

  " line diffing
  call dein#add('AndrewRadev/linediff.vim')

  " Language-specific syntax support, completions:

  " Live LaTeX previewing
  "call dein#add('xuhdev/vim-latex-live-preview')

  " Different LaTeX live previewing (vllp currently broken for TeXLive2016 ?)
  "call dein#add('donRaphaco/neotex')
  " no, I think this only works for vim?

  " Syntax highlighting for coffeescript
  call dein#add('kchmck/vim-coffee-script')

  " Support for Julia
  call dein#add('JuliaEditorSupport/julia-vim')

  " toml syntax
  call dein#add('cespare/vim-toml')

  " nix expression language
  call dein#add('LnL7/vim-nix')

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
  call dein#install()
endif

"End dein Scripts-------------------------


"""
" Personal Settings
"""


"""
" Look and Feel
"""

" colorscheme gruvbox
colorscheme wal
set background=dark
set relativenumber number
set expandtab tabstop=4 softtabstop=4 shiftwidth=4 softtabstop=4

" allow mouse control
set mouse=a

" zsh-style tab completion
set wildmenu
set wildmode=full

" case-insensitive, smart search for /, ?
set ignorecase smartcase

" hide modified buffers (allow opening of new buffers if current is edited)
set hidden

" autoread changes made outside vim
set autoread

" persistent undo!
au BufWritePre * setlocal undofile

" file explorer sidebar
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20


"""
" Personal definitions
"""

let mapleader=","

" Copy to clipboard (mac uses * register: linux uses + reg)
vnoremap <leader>y "*y
nnoremap <leader>Y "*yg_
nnoremap <leader>y "*y
nnoremap <leader>yy "*yy

" Paste from clipboard
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>p "*p
vnoremap <leader>P "*P

" Buffer control

" Cycle through buffers
nmap <leader>n :bnext<CR>
nmap <leader>N :bprev<CR>

" Cycle through tabs
nmap <leader>m :tabn<CR>
nmap <leader>M :tabp<CR>

" Cycle through splits (in same window)
nmap <leader>w <C-W><C-W>

" force kill those damn term bufs
nmap <leader>d :bd!<CR>

" move to next buffer and kill the previous one (good for keeping window layout)
nmap <leader>b :bn \| bd # <CR>

" clear highlighted matches from find
nmap <leader><Space> :noh<CR>

" for exiting nvim terminal mode
tnoremap <Esc> <C-\><C-n>

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

autocmd BufNewFile,BufRead {kwmrc,.khdrc} set syntax=kwm

" disable linting for temporary .py files
autocmd BufWinEnter *.dis.py :NeomakeDisableBuffer

" auto-compile rust files
autocmd BufWritePost *.rs !cargo run

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


"""
" Plugin Settings and Keybinds
"""


" gitgutter
set updatetime=100
nmap ghn <Plug>GitGutterNextHunk
nmap ghp <Plug>GitGutterPrevHunk


" deoplete settings
let g:deoplete#enable_at_startup=1

" completion engines
let g:deoplete#sources#clang#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
" this will chang with each upgrade! symlink?
let g:deoplete#sources#clang#clang_header='/Library/Developer/CommandLineTools/usr/lib/clang/8.0.0/include'

" python info for deoplete
let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'

" Rust Auto-Complete-ER
let g:racer_cmd = "/Users/Amar/.cargo/bin/racer"

" close the deoplete preview window on autocomplete
autocmd CompleteDone * pclose

" deoplete tab-complete:
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>" 


" ultisnip settings
" <c-j>, <c-k> : jump forward, backward, respectively
let g:UltiSnipsExpandTrigger="<c-j>"


" mappings for Linediff
vnoremap <leader>d	:Linediff<CR>


" neomake settings
" how to lint with python3?
" let g:neomake_python_pylint_exe = 'python3'

" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)

" red
hi NeomakeErrorSign ctermfg=1
" white
hi NeomakeWarningSign ctermfg=7
" blue (?)
hi NeomakeMessageSign ctermfg=4
" green (?)
hi NeomakeInfoSign ctermfg=2

let g:neomake_error_sign =   {'text' : 'x', 'texthl' : 'NeomakeErrorSign'}
let g:neomake_warning_sign = {'text' : '!', 'texthl' : 'NeomakeWarningSign'}
let g:neomake_message_sign = {'text' : '>', 'texthl' : 'NeomakeMessageSign'}
let g:neomake_info_sign =    {'text' : 'i', 'texthl' : 'NeomakeInfoSign'}


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


" vimwiki path
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/'}]


" vim-latex-live-preview
let g:livepreview_previewer = 'evince'
nnoremap <leader>L :LLPStartPreview<CR>
" live previewing currently broken?
"autocmd TextChanged,TextChangedI *tex silent :LLPStartPreview 

" neotex settings
"let g:neotex_enabled = 0


" airline-vim, airline-vim-themes settings
let g:airline#extensions#branch#enabled = 1

" wip : rename other modes?
let g:airline_mode_map = {
	\ 'n' : 'normie',
	\ 'i' : 'hardcore hacking',
	\ 'R' : 'swappity swip',
	\ 'v' : 'look',
	\ 'V' : 'line look',
	\ '' : 'block look',
	\ 'c' : 'commando',
	\ 's' : 'pick dat',
	\ 'S' : 'pick dem',
	\ '' : 'pick doze',
	\ 't' : 'powershell',
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
