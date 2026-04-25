" Add the cursor position to the current quickfix list
function AddPosToQuickfix() abort
    let line = getpos('.')[1]
    let col = getpos('.')[2]
    execute printf("caddexpr ['%s:%d:%d:%s']",
    \ bufname(),
    \ line,
    \ col,
    \ getbufoneline(bufnr(), line))
endfunction

" Alternate version using `setqflist()` (more idiomatic)
function AddPosToQuickfix() abort
    let line = getpos('.')[1]
    let col = getpos('.')[2]
    call setqflist([{
    \ 'filename': bufname(),
    \ 'lnum': line,
    \ 'col': col,
    \ 'text': getbufoneline(bufnr(),l:line)}],
    \ 'a')
endfunction
