function FoldTab(lineNr) abort
    let curLine = getline(a:lineNr)
    let prevLine = getline(a:lineNr - 1)
    let curIndentTabNr = strlen(matchstr(curLine, '\v^\t*'))
    let prevIndentTabNr = strlen(matchstr(prevLine, '\v^\t*'))

    if curLine ==# ""
        if prevIndentTabNr > 0
            return "="
        endif
    elseif curIndentTabNr > 0
        return curIndentTabNr + 1
    else
        return 1
    endif
endfunc

set foldexpr=FoldTab(v:lnum)
