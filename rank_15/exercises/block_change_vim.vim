" Solution of exercise 5 for Vim

onoremap <expr> ibc &diff ? ':call s:SelectChangeBlock()<cr>' : 'ibc'

function SelectChangeBlock() abort
    let changeBlock = s:CurrentChangeBlock()
    execute changeBlock[0]
    normal! V
    execute changeBlock[1]
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

" Get all the change blocks as a list of line ranges
" For example: [[1,1],[2,5]] -> two block of changes, from line 1 to line 1 (one line), and from line 2 to line 5 included (4 lines)
function s:ChangeBlocks() abort
    " Determine what buffer to compare to
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

    " Get the diff info we need
    let diff = diff(getbufline(bufnr(), 1, '$'), getbufline(otherBufNr, 1, '$'), {'output': 'indices'})
    let ranges = []
    for d in diff
        " from_* is about the current buffer, not the one compared to
        " If there is no line count, there is no change block in the current buffer
        if d.from_count != 0
            " Line number is from_idx + 1
            let start = d.from_idx + 1
            " End of block is from_idx + from_count
            let end = d.from_idx + d.from_count
            call add(ranges, [start, end])
        endif
    endfor

    return ranges
endfunction
