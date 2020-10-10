let mapleader=","

syn on

if has("gui_macvim")
  colorscheme solarized
  set background=dark
  set guifont=Inconsolata:h14
endif

if has("nvim")
  hi ALEWarning ctermbg=red
endif

set number
set sts=2 sw=2 expandtab
set vb

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
  let term_position = get(g:, 'test#vim#term_position', 'botright')
  execute term_position . ' new'
  call term_start(['/bin/bash', '-ic', a:cmd], {'curwin': 1, 'term_name': a:cmd})
  au BufLeave <buffer> wincmd p
  nnoremap <buffer> <Enter> :q<CR>
  redraw
  echo "Press <Enter> to exit test runner terminal (<Ctrl-C> first if command is still running)"
endfunction

let g:test#custom_strategies = {'vim8terminal': function('Vim8RunStrategy')}
let g:test#strategy = 'neovim'

nmap <leader>l :TestLast<CR>
nmap <leader>T :TestFile<CR>
nmap <leader>n :TestNearest<CR>

nmap gs :Gstatus<CR>
nmap gc :Gcommit<CR>
nmap gr :Grebase origin/master

set shell=/bin/zsh
set shellcmdflag=-ic

augroup vimrc
  autocmd QuickFixCmdPost * botright copen 8
augroup END

let g:airline#extensions#ale#enabled = 1

let g:ale_completion_enabled = 1

" don't run ALE whenever the file changes
let g:ale_lint_on_text_changed = 'never'

if !has("gui_macvim")
  nmap <leader>t :PickerEdit<cr>
  nmap <leader>b :PickerBuffer<cr>
endif
