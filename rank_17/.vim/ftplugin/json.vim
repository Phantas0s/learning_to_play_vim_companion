let &l:formatprg='jq .'

nnoremap <buffer><localleader>m <cmd>%s/\_s//g<cr>

command! -buffer -range=% <line1>,<line2>!jq .
