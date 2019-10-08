let b:ale_linters = ['rubocop']
let b:ale_fixers = ['rubocop']

nmap <leader>a :Ack <C-r><C-w> -g "!_test.rb"
nmap <leader>d :Ack "def <C-r><C-w>" -g "!_test.rb"
