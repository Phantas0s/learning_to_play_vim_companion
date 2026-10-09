augroup vimrc
    autocmd!
augroup END

" Show the arglist if there are at least 2 buffers in it
autocmd vimrc VimEnter * call ShowArglistLine()
function ShowArglistLine()
    set showtabline=2
    let argLen = argc(-1)
    if argLen <= 1
        set showtabline=0
    endif
endfunction

function ArglistLine() abort
    " Go through all buffers of the global arglist
    let current = 1
    let line = ""
    while current <= argc(-1)
        if current == argidx() + 1
            let line .= '%#TabLineSel#'
        else
            let line .= '%#TabLine#'
        endif
        let line .= current .. ":"
        let line .= argv(current - 1) .. " "
        let current += 1
    endwhile

    return line
endfunction

set tabline=%!ArglistLine()
