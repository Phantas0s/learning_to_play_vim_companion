function CeditComplete(argLead, cmdLine, cursorPos) abort
    " -p adds a final slash to the name of a directory.
    " grep -v '/' excludes all files with a slash (so all directories)
    return system($"ls -p {shellescape(expand('%:h'))} | grep -v '/' | grep -v {shellescape(expand('%:t'))}")
endfunc

command -nargs=1 -complete=custom,CeditComplete Cedit edit %:h/<args>
