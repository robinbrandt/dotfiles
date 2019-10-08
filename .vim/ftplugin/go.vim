" we're using vim-go which already takes care of everything
"

let b:ale_linters_explicit = 1

let b:ale_linters = []
let b:ale_fixers = []

nmap <leader>T <Plug>(go-test)
nmap <leader>d :GoDef<CR>

set noet ci pi sts=0 sw=8 ts=8
