function Inspect() abort
    for id in synstack(line("."), col("."))
        let synGroup = synIDattr(id, "name")
        if synGroup != ""
            execute "syntax list" synGroup
        endif

        let linkedGroup = synIDattr(synIDtrans(synID(line("."), col("."), 0)), 'name')
        if linkedGroup != ""
            execute "highlight" linkedGroup
        endif
    endfor
endfunction

command! Inspect call Inspect()
