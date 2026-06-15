function Change(...) abort
    " Extract the extension as first argument
    " and delete if from the list of arguments
    let args = deepcopy(a:000)
    let extension = copy(args[0])
    call remove(args,0)

    " Since <f-args> create a different argument if there is a space,
    " and since an Ex command can contain spaces,
    " we try to bring back the Ex command together by concatenating these arguments.
    let excmd = ""
    for arg in args
            let excmd ..= " " .. arg
    endfor

    let currentBuffer = bufname()

    " Save all buffer IDs into the list oldBufferList
    let buffers = split(execute("ls"), '\n')
    let oldBufferList = []
    for i in buffers
        call add(oldBufferList, split(i)[0])
    endfor

    " Add all Go files into the arglist
    execute $"arg **/*.{extension}"
    " Run the Ex command given as argument on all Go files and write them if they were modified
    " Output and errors are never displayed
    silent! argdo execute excmd "| update"

    " Come back to the current buffer before running argdo
    execute $"buffer {currentBuffer}"

    let newBufferList = split(execute("ls"), '\n')
    " Wipe all buffers which were not open before running argdo
    for i in newBufferList
        let bufID = split(i)[0]
        if index(oldBufferList, bufID) < 0
            execute "bwipe" bufID
        endif
    endfor
endfunc

" For example:
" :Change go %s/Create/Invoke/g
command! -nargs=+ -complete=command Change call Change(<f-args>)
