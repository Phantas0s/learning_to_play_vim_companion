function DeleteTrailingWS() abort
    let cursor = getcurpos()
    %s/\v\s+$//ge
    " Vimscript lists begin with the index 0
    call cursor(cursor[1], cursor[2])
endfunc
