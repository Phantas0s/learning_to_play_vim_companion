setlocal foldmethod=expr

" Using the prefix s: makes the function only available in this script.
" Any other function in any other file sourced by Vim could have this function name without conflict.
function s:FoldTab(lineNr) abort
    let curLine = getline(a:lineNr)
    if curLine ==? ""
        return '='
    else
        return strlen(matchstr(curLine, '\v^\t*'))
    endif
endfunc

setlocal foldexpr=s:FoldTab(v:lnum)

" Mapping to create a struct tag
nnoremap <buffer> <leader>t ^yiWA<space>`json:"<c-r>""`<esc>guaW
