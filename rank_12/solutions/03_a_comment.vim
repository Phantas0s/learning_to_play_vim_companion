function AComment() abort
    " Search forward for the end of the block; move the cursor.
    " 'c' accepts a match at the cursor position, in case we're on a delimiter.
    " 'W' doesn't wrap around the end of the file, not deleting the first block if there is no next block in the buffer.
    let endBlock = search('\V]]--', 'cW')
    if endBlock != 0
        " Search for the start of the block.
        " 'b' searches backward.
        " 'n' doesn't move the cursor.
        " 'c' accepts a match at the cursor position, in case we're on a delimiter.
        let startBlock = search('\V--[[', 'bnc')

        execute startBlock
        normal! V
        execute endBlock
    endif
endfunc

onoremap ac :<c-u>call AComment()<cr>
xnoremap ac :<c-u>call AComment()<cr>
