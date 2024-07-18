let &l:formatprg='jq .'

nnoremap <buffer><localleader>m :%s/[ \s\r\n]//g<cr>

command -buffer Jq %!jq .
