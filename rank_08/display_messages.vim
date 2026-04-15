function DisplayMessages(...) abort
    for mes in a:000
        echom mes
    endfor

    echom 'Number of arguments: ' .. a:0

    if a:0 > 0
        echom 'The first argument is: ' .. a:1
    endif
endfunc
