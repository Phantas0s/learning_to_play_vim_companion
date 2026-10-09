function s:ChangeBlocks() abort
    let otherBufNr = 0

    let rightBufNr = winbufnr(winnr('l'))
    let leftBufNr = winbufnr(winnr('h'))

    if rightBufNr == bufnr()
        let otherBufNr = leftBufNr
    elseif leftBufNr == bufnr()
        let otherBufNr = rightBufNr
    elseif rightBufNr == leftBufNr == bufnr
        throw 'You need a left or right window to use this text-object'
    endif

    let diff = diff(getbufline(bufnr(), 1, '$'), getbufline(otherBufNr, 1, '$'), {'output': 'indices'})

    let ranges = []
    for d in diff
        " from_* is about the current buffer, not the one compared to
        " If there is no line count, there is no change block in the current buffer
        if d.from_count != 0
            " Start of block is: from_idx + 1
            let start = d.from_idx + 1
            " End of block is: from_idx + from_count
            let end = d.from_idx + d.from_count
            call add(ranges, [start, end])
        endif
    endfor
    return ranges
endfunction

function s:CurrentChangeBlock() abort
    let blocks = s:ChangeBlocks()
    let currentLine = line('.')
    for bl in blocks
        if currentLine >= bl[0] && currentLine <= bl[1]
            return bl
        endif
    endfor
endfunction

function s:SelectChangeBlock() abort
    let changeBlock = s:CurrentChangeBlock()

    if empty(s:CurrentChangeBlock())
        return ''
    endif

    execute changeBlock[0]
    normal! V
    execute changeBlock[1]
endfunction

" Mapping only works if the current window is in diff mode
onoremap <expr> ibc &diff ? '<cmd>call <sid>SelectChangeBlock()<cr>' : 'ibc'
