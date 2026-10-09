command DiffIBlankToggle call DiffIBlankToggle()

function DiffIBlankToggle() abort
    " Regex matching operator =~
    if &diffopt =~ 'iblank'
        set diffopt-=iblank
    else
        set diffopt+=iblank
    endif
endfunction
