function DeleteTrailingWS() abort
    normal mz
    %s/\v\s+$//ge
    normal `z
endfunc

function RemoveDirectories(...)
    for arg in a:000
        let choice = confirm("Remove directory '" .. arg .. "'?", "&Yes\n&No")
        if choice == 1
            call delete(arg, "rf")
        endif
    endfor
endfunction

function! Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

function WordCount() abort
    if (&ft!="markdown")
        return ""
    endif

    return wordcount()['words'] .. " words "
endfunction
