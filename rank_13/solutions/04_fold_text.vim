function s:FoldText() abort
    if &foldmethod ==# 'marker'
        let firstLine = substitute(getline(v:foldstart), '\v^.*\zs\{{3}\ze.*$', '{...}', '')
    else
        let firstLine = getline(v:foldstart)
    endif

    let countLines = v:foldend - v:foldstart + 1

    return $"{firstLine} {countLines}"
endfunc

set foldtext=s:FoldText()
