function BufferLine() abort
    let line = ""
    " Range through all buffers open
    for i in range(bufnr('$'))
        let bufIndex = i+1

        " If the buffer is the current buffer
        if bufIndex == bufnr()
            let line .= "["
        endif

        let line .= bufIndex .. '-' .. bufname(bufIndex)

        if bufIndex == bufnr()
            let line .= "] "
        else
            let line .= " "
        endif
    endfor

    return line
endfunction

set tabline=%!BufferLine()
