function VisualSearchForward()
    " Save the current values of the registers
    let cunnamed = @"
    let cyank = @0

    " Yank the selection
    normal! y

    " Escape any backslash to avoid interpreting it as an escape sequence
    let yank = escape(getreg('0'), '\')

    " Search for the yanked text
    " \V makes the pattern 'very nomagic' (always literal)
    call search('\V' .. yank)

    " Set the yanked selection as value for the search register
    " Enables n and N in normal mode
    let @/ = yank

    " Restore the previous values of the registers
    let @" = cunnamed
    let @0 = cyank
endfunction

xnoremap * <cmd>call VisualSearchForward()<cr>
