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

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " colorscheme
  call dein#add('morhetz/gruvbox')

  " sensible settings
  call dein#add('tpope/vim-sensible')

  " completion (remember to call ./install.py to generate completions!)
  "call dein#add('Valloric/YouCompleteMe')

  " python completion (YCM uses Jedi)
  "call dein#add('davidhalter/jedi-vim')

  " deoplete for nvim: try usurping YCM?
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-jedi')

  " git gutter
  call dein#add('airblade/vim-gitgutter')

  " git fugitive
  call dein#add('tpope/vim-fugitive')

  " (vim plugin) minimap
  call dein#add('severin-lemaignan/vim-minimap')
  
  " powerline that works with neovim
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " bash and tmux airline-prompt generators
  call dein#add('edkolev/promptline.vim')
  call dein#add('edkolev/tmuxline.vim')

  " for surrounding phrases with characters
  call dein#add('tpope/vim-surround')

  " nice completion of (x)html tags
  call dein#add('tpope/vim-ragtag')

  " Syntax highlighting for coffeescript
  call dein#add('kchmck/vim-coffee-script')

  " Live LaTeX previewing
  "call dein#add('xuhdev/vim-latex-live-preview')

  " Support for Julia
  call dein#add('JuliaEditorSupport/julia-vim')

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

" Clear SignColumn (git symbols) so it's same as background, recolor git symbols
hi clear SignColumn
hi SignColumn ctermbg=235
" linenr: ctermfg=245 for all symbols				  Defaults:
hi GitGutterAdd ctermbg=235 ctermfg=142				" GruvboxGreenSign fg/bg 142/237
hi GitGutterChange ctermbg=235 ctermfg=108			" GruvboxAquaSign fg/bg 108/237
hi GitGutterDelete ctermbg=235 ctermfg=167			" GruvboxRedSign fg/bg 167/237
hi GitGutterChangeDelete ctermbg=235 ctermfg=108	" GruvboxAquaSign fg/bg 108/237

" hide modified buffers (allow opening of new buffers if current is edited)
set hidden

"""
" Personal definitions
"""

" auto-reload config
"augroup AutoCommands
"	au!
"    autocmd BufWritePost $MYVIMRC source $MYVIMRC 
"augroup END

augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * mkview
  "autocmd BufWinEnter * silent loadview
augroup END

let mapleader=","

" Copy to clipboard (mac uses * register: linux uses + reg)
vnoremap <leader>y "*y
nnoremap <leader>Y "*yg_
nnoremap <leader>y "*y
nnoremap <leader>yy "*+yy

" Paste from clipboard
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>p "*p
vnoremap <leader>P "*P

" Buffer movement
nmap <leader>n :bnext<CR>	" Cycle through buffers
"nmap <leader>m :bprev<CR>	" use this for tab-switching?
nmap <leader>w <C-W><C-W>	" Cycle through splits (in same window)

" clear highlighted matches from find
nmap <leader><Space> :noh<CR>

" Hide status bar on command Shift+H
" From http://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom
let s:hidden_all = 0
function! ToggleHiddenAll()
	if s:hidden_all == 0
		let s:hidden_all = 1
		set noshowmode
		set noruler
		set laststatus=0
		set noshowcmd
	else
		let s:hidden_all = 0
		set showmode
		set ruler
		set laststatus=2
		set showcmd
	endif
endfunction

" also want to programmatically hide airline buffer at top (how to do this?)
function! TogBuf()
	if g:airline#extensions#tabline#enabled == 1
		let g:airline#extensions#tabline#enabled = 0
	else
		let g:airline#extensions#tabline#enabled = 1
	endif
endfunction

"nnoremap <S-j> :call TogBuf()<CR>
nnoremap <S-h> :call ToggleHiddenAll()<CR>

"""
" Plugin Settings and Keybinds
"""

" vim-minimap settings
let g:minimap_show='<leader>ms'
let g:minimap_update='<leader>mu'
let g:minimap_close='<leader>gc'
let g:minimap_toggle='<leader>gt'

" TODO chromatica settings
let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
let g:chromatica#enable_at_startup=1

" deoplete settings
let g:deoplete#enable_at_startup=1
let g:deoplete#sources#clang#libclang_path='/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
" this will chang with each upgrade! symlink?
let g:deoplete#sources#clang#clang_header='/Library/Developer/CommandLineTools/usr/lib/clang/8.0.0/include'

let g:python_host_prog='/usr/local/bin/python'
let g:python3_host_prog='/usr/local/bin/python3'
" close the deoplete preview window on autocomplete
autocmd CompleteDone * pclose
" deoplete tab-complete:
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>" 


" airline-vim, airline-vim-themes settings
" TODO
let g:airline#extensions#branch#enabled = 1

" Default:
 " let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
 " let g:airline_section_b       (hunks, branch)
 " let g:airline_section_c       (bufferline or filename)
 " let g:airline_section_gutter  (readonly, csv)
 " let g:airline_section_x       (tagbar, filetype, virtualenv)
 " let g:airline_section_y       (fileencoding, fileformat)
 " let g:airline_section_z       (percentage, line number, column number)
 " let g:airline_section_error   (ycm_error_count, syntastic, eclim)
 " let g:airline_section_warning (ycm_warning_count, whitespace)
" Changes:
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

" (used to use) promptline customization to generate bars for for bash/fish and tmux
" :PromptlineSnapshot [theme] [preset]
" :TmuxlineSnapshot [theme] [preset]
"so promptline_settings.vim

