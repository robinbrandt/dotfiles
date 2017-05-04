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
