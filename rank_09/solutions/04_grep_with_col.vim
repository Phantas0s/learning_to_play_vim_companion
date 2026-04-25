" Search using ripgrep in one or multiple files, and create a new quickfix list
function! GrepWithCol(pattern, ...) abort
    if a:0 == 0
        throw "At least one file must be specified"
    endif

    let files = a:000
    let cmd = printf('rg --column --line-number --no-heading --vimgrep %s %s',
      \ shellescape(a:pattern),
      \ join(files))

    " Call the shell command and return a Vimscript list
    let output = systemlist(cmd)

    " return early if the shell command returns an error
    if v:shell_error
        return
    endif

    let clist = []
    for line in output
        let parts = split(line, ':')
        " Reconstruct the message if it contains some colons
        let message = join(parts[3:], ':')
        if len(parts) >= 4
            call add(clist, {
                \ 'filename': parts[0],
                \ 'lnum': str2nr(parts[1]),
                \ 'col': str2nr(parts[2]),
                \ 'text': message
            \})
        endif
    endfor

    call setqflist(clist)
endfunction
