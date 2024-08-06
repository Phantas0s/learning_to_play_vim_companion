function DeleteTrailingWS() abort
    normal mz
    %s/\v\s+$//ge
    normal `z
endfunc

function RemoveDirectory(dir)
    let choice = confirm("Remove directory '"..a:dir.."'?", "Yes\nNo")
    if choice == 1
        call delete(a:dir,"rf")
    endif
endfunction

