let mapleader=","

syn on

if has("gui_macvim")
  colorscheme solarized
  set background=dark
endif

set number

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

set sts=2 sw=2 expandtab

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

let test#strategy = 'asyncrun'

nmap <silent> <leader>n :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>l :TestLast<CR>

augroup vimrc
  autocmd QuickFixCmdPost * botright copen 8
augroup END

set shell=/usr/local/bin/bash
set shellcmdflag=-ic
