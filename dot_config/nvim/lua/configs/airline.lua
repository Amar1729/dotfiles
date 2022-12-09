-- just run this whole config as vim.cmd for now
vim.cmd [[

" airline-vim, airline-vim-themes settings
let g:airline#extensions#branch#enabled = 1

let g:airline_detect_spell = 0

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
	let g:airline_section_a = airline#section#create(['mode','crypt','paste','iminsert'])
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
let g:airline_section_y = ''
let g:airline_section_z = '%v:%l/%L'
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

if $EDITOR_LOOK == 'block'
  " decreasing block style
  let g:airline_left_sep = '▊▌▎▏'
  let g:airline_left_alt_sep = '▏▎'
  let g:airline_right_sep = '▏▎▌▊'
  let g:airline_right_alt_sep = '▎▏'
else
  " default: airline style
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
endif

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

]]
