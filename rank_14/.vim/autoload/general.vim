function general#DeleteTrailingWS() abort
    normal mz
    %s/\v\s+$//ge
    normal `z
endfunc

function general#RemoveDirectories(...)
    for arg in a:000
        let choice = confirm("Remove directory '" .. arg .. "'?", "&Yes\n&No")
        if choice == 1
            call delete(arg, "rf")
        endif
    endfor
endfunction
