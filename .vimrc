let mapleader=","

syn on

if has("gui_macvim")
  colorscheme solarized
  set background=dark
  set guifont=Inconsolata:h14
endif

set number
set sts=2 sw=2 expandtab

" Ruby library
set rubydll=/usr/local/lib/libruby.dylib

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
  call term_start(['/usr/local/bin/bash', '-ic', a:cmd])
endfunction

let g:test#custom_strategies = {'vim8terminal': function('Vim8RunStrategy')}
let g:test#strategy = 'vim8terminal'

function! FormatBufferRubocop()
  setlocal autoread
  silent execute "!bundle exec rubocop -a %"
  edit
  setlocal noautoread
endfunction

nmap <leader>l :execute "silent !tmux send-keys 'rails t " . expand("%") . ":" . line(".") . "'\r"<CR>
nmap <leader>T :execute "silent !tmux send-keys 'rails t " . expand("%") . "'\r"<CR>
nmap <silent> <leader>F :call FormatBufferRubocop()<CR>

map  :Ack 

set shell=/usr/local/bin/bash
set shellcmdflag=-ic

augroup vimrc
  autocmd QuickFixCmdPost * botright copen 8
augroup END

let g:airline#extensions#ale#enabled = 1

" don't run ALE whenever the file changes
let g:ale_lint_on_text_changed = 'never'

" use git for command-t file list
let g:CommandTFileScanner='git'

" switch to FZY instead of command-t for command line vim
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

if !has("gui_macvim")
  nmap <leader>t :call FzyCommand("git ls-files", ":e")<cr>
endif
