let s:foldLevel = 0

function s:FoldMarkdownSection(lineNr)
    let curLine = getline(a:lineNr)
    let curHeaderLevel = strlen(matchstr(curLine, '\v^#+'))

    let nextLine = getline(a:lineNr + 1)
    let nextHeaderLevel = strlen(matchstr(nextLine, '\v^#+'))

    if curHeaderLevel > 0
        let g:foldLevel = curHeaderLevel
    " We need to break the current fold if we enter a new section of same level,
    " or if the section level gets lower.
    elseif nextHeaderLevel <= g:foldLevel && nextHeaderLevel > 0
        let g:foldLevel -= 1
    endif

    return g:foldLevel
endfunc

setlocal foldmethod=expr
setlocal foldexpr=s:FoldMarkdownSection(v:lnum)
