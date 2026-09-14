function s:FoldText() abort
    if &foldmethod ==# 'marker'
        let firstLine = substitute(getline(v:foldstart), '\v^.*\{{3}\ze.*$', '{...}', '')
    else
        let firstLine = getline(v:foldstart)
    endif

    let countLines = v:foldend - v:foldstart + 1

    " Add padding the size of the window minus the size of the line,
    " and the size of the count of lines.
    let padding = winwidth(0) - strlen(firstLine) - strlen(countLines)

    " Adjust the padding depending on the size of the right hand size column.
    if &number || &relativenumber
        let padding -= &numberwidth
    endif

    if &foldcolumn
        let padding -= &foldcolumn
    endif

    return $"{firstLine}{repeat(' ', padding)}{countLines}"
endfunc

set foldtext=s:FoldText()
