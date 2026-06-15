function BdAll(bang) abort
    let buffers = split(execute("ls"), '\n')
    for i in buffers
        let bufID = split(i)[0]
        " If it's not the current buffer, delete it
        if  bufID != bufnr()
            execute printf("silent! bdelete%s %d", a:bang, bufID)
        endif
    endfor
endfunction

command -bang BdAll call BdAll("<bang>")
