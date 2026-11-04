function RedirFile(...) abort
    let cmd = join(a:000[1:], ' ')
    execute 'redir >>' a:1
    execute cmd
    redir END
endfunction
command! -nargs=* -complete=command RedirFile silent call RedirFile(<f-args>)
