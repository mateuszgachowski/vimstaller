execute pathogen#infect()

" Syntax settings
syntax enable
filetype plugin indent on
set number
set cursorline
highlight LineNr     term=bold cterm=NONE ctermfg=White ctermbg=NONE gui=NONE guifg=Black guibg=NONE
highlight CursorLine cterm=NONE ctermbg=Black ctermfg=NONE guibg=NONE guifg=NONE
highlight Pmenu      ctermfg=black ctermbg=white
highlight PmenuSel   ctermfg=white ctermbg=black

" Airline config
let g:airline#extensions#tabline#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_left_sep=' '
let g:airline_right_sep=' '
let g:airline_left_alt_sep='> '
let g:airline_right_alt_sep=' <'
set laststatus=2

" Autoreload Vimrc whenever it changes
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Tab and indentation settings
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

" Navigation
" 2x Fast
nmap <s-j> 2j
nmap <s-k> 2k
nmap <s-h> 2h
nmap <s-l> 2l

" 4x Fast
nmap <c-j> 4j
nmap <c-k> 4k
nmap <c-h> 4h
nmap <c-l> 4l

" NerdTree
noremap <silent> <C-n> :NERDTreeFocus<CR>

" Less (compile on save)
nnoremap <Leader>m :w <BAR> !lessc % > %:t:r.css<CR><space>
