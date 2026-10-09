function BufferLine() abort
    let line = ""
    " Range through all buffers open
    for i in range(bufnr('$'))
        let bufIndex = i+1
        let line .= bufIndex .. '-' .. bufname(bufIndex) .. " "
    endfor

    return line
endfunction

set tabline=%!BufferLine()
