set number

function CycleLineNumbers() abort
    if &number == v:true && &relativenumber == v:false
        set relativenumber
    elseif &relativenumber == v:true && &number == v:true
        set norelativenumber nonumber
    else
        set number
    endif
endfunction

nnoremap <c-n> <cmd>call CycleLineNumbers()<cr>
