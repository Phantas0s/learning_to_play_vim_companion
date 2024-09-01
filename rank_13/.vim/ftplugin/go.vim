setlocal foldmethod=expr

" Using the prefix s: makes the function only available in this script.
" Any other function in any other file sourced by Vim could have this function name without conflict.
function s:FoldTab(line_num) abort
    let cur_line = getline(a:line_num)
    if cur_line ==? ""
        return '='
    else
        return strlen(matchstr(cur_line, '\v^\t*'))
    endif
endfunc

setlocal foldexpr=s:FoldTab(v:lnum)
