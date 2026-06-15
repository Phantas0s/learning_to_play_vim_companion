function GoChange(cmd) abort
    let currentBuffer = bufname()

    " Save all buffer IDs into the list oldBufferList
    let buffers = split(execute("ls"), '\n')
    let oldBufferList = []
    for i in buffers
        call add(oldBufferList, split(i)[0])
    endfor

    " Add all Go files into the arglist
    arg **/*.go
    " Run the Ex command given as argument on all Go files and write them if they were modified
    " Output and errors are never displayed
    silent! argdo execute a:cmd "| update"

    " Come back to the current buffer
    execute $"buffer {currentBuffer}"

    let newBufferList = split(execute("ls"), '\n')
    " Wipe all buffers which were not open
    for i in newBufferList
        let bufID = split(i)[0]
        if index(oldBufferList, bufID) < 0
            execute "bwipe" bufID
        endif
    endfor
endfunc

command! -nargs=1 -complete=command GoChange call GoChange(<q-args>)
