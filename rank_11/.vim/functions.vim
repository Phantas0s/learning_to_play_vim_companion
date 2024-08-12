function DeleteTrailingWS() abort
    normal mz
    %s/\v\s+$//ge
    normal `z
endfunc

function RemoveDirectories(...)
    for arg in a:000
        let choice = confirm("Remove directory '" .. arg .. "'?", "Yes\nNo")
        if choice == 1
            call delete(arg, "rf")
        endif
    endfor
endfunction
