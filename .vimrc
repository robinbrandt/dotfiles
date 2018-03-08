let mapleader=","

syn on

if has("gui_macvim")
  colorscheme solarized
  set background=dark
endif

set number
set sts=2 sw=2 expandtab

" Ackvim configuration
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

if executable('rg')
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

set nocompatible      " We're running Vim, not Vi!
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

fun! StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd FileType ruby,json,yaml autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()

" Running tests inside Vim 8
function! Vim8RunStrategy(cmd)
  "execute 'terminal bash -ic "' . a:cmd . '"'
  if bufwinnr('!/usr/local/bin/bash') < 0
    execute 'terminal'
  endif
  call term_sendkeys('!/usr/local/bin/bash', a:cmd . '')
endfunction

let g:test#custom_strategies = {'vim8terminal': function('Vim8RunStrategy')}
let g:test#strategy = 'vim8terminal'

function! FormatBufferRubocop()
  setlocal autoread
  silent execute "!bin/rubocop -a %"
  edit
  setlocal noautoread
endfunction

nmap <silent> <leader>n :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>F :call FormatBufferRubocop()<CR>

set shell=/usr/local/bin/bash
set shellcmdflag=-ic

augroup vimrc
  autocmd QuickFixCmdPost * botright copen 8
augroup END

let g:airline#extensions#ale#enabled = 1

" use git for command-t file list
let g:CommandTFileScanner='git'
