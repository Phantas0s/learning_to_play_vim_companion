function GoRun(cmd) abort
    arg **/*.go
    argdo execute a:cmd
endfunc

command -nargs=1 -complete=command GoRun call GoRun(<q-args>)
