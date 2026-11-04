function s:GetDigraphsList() abort
    let list = []

    redir => output
    silent digraphs
    redir END

    " Match each digraph / character / decimal representation.
    " For example: NU ^@  10
    " Each part captured in a group to create a list later.
    let pattern = '\v(\S{2})\s+(\S{1,2})\s+(\d+)'
    " Index of the next digraph
    let digraphIdx = 0

    while 1
        " Create a list using the pattern's groups
        let match = matchlist(output, pattern, digraphIdx)
        if empty(match)
            break
        endif
        call add(list, [match[1], match[2], match[3]])
        " Move the index to the next digraph
        let digraphIdx = matchend(output, pattern, digraphIdx)
    endwhile

    return list
endfunction

function! s:FindDigraph(query)
    let digraphs = s:GetDigraphsList()
    let matches = []

    for entry in digraphs
        " =~? matches regex and ignore case
        if entry[0] =~? a:query || entry[1] =~? a:query || entry[2] =~? a:query
            call add(matches, printf('%s %s %s', entry[0], entry[1], entry[2]))
        endif
    endfor

    if empty(matches)
        echom 'No digraphs found matching: ' .. a:query
    else
        for match in matches
            echom match
        endfor
    endif
endfunction

command! -nargs=1 FindDigraph call s:FindDigraph(<q-args>)
