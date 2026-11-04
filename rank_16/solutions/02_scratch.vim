function general#Scratch(cmd)
    let output = ""

    " If the command begins with a bang "!"
    if a:cmd[0] == '!'
        " Copy the command to be able to modify it
        let cmd = a:cmd
        if cmd =~ ' %'
            let cmd = substitute(cmd, ' %', ' ' .. shellescape(expand('%:p')), '')
        endif
        let output = system(shellescape(cmd[1:]))
    else
        " save the redirection into a variable
        redir => output
        execute a:cmd
        redir END
    endif

    let output = split(output, "\n")

    for win in range(1, winnr('$'))
        if getwinvar(win, 'scratch')
            execute win .. 'close'
        endif
    endfor

    vnew
    let w:scratch = 1
    setlocal buftype=nofile bufhidden=hide noswapfile

    call setbufline(bufnr(), 1, output)
endfunction

command! -nargs=1 Scratch silent call Scratch(<q-args>)
