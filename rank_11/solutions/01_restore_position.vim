function RestorePosition() abort
    " Vimscript lists begin with index 0.
    let l:line = getpos("'\"")[1]
    let l:col = getpos("'\"")[2]
    call cursor(line, col)
endfunc
