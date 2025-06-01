function general#Scratch(cmd)
    " save the redirection into a variable
    redir => output
    execute a:cmd
    redir END

    let output = split(output, "\n")

    if bufexists(bufname('scratch')) == v:false
        vnew scratch
        setlocal buftype=nofile bufhidden=hide noswapfile
    endif

    " Delete the scratch buffer content
    call deletebufline(bufnr('scratch'), 1, '$')
    call setbufline(bufnr('scratch'), 1, output)
endfunction
