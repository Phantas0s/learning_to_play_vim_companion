function TestComplete(argLead, cmdLine, cursorPos) abort
    " -p adds a final slash to directories' names
    " grep -v '/' exclude all files with a slash (so all directories)
    return system($"ls -p {shellescape(expand('%:h'))} | grep -v '/' | grep -v '{shellescape(expand('%:t'))}'")
endfunc

function CreateTestFile(...) abort
    " see :help lambda
    let IsTestFile = { filename -> match(filename, '\V_test.go\$') != -1 ? v:true : v:false }

    let filepath = ""
    if a:0 == 1
        let baseFile = a:1
        let testFile = ""
        if IsTestFile(baseFile)
            let testFile = baseFile
        else
            let testFile = substitute(baseFile, '\v(\.go)$', '_test\1', "")
        endif

        let filepath = expand('%:h') .. "/" .. testFile
    else
        let baseFile = expand('%')
        if IsTestFile(baseFile)
            return
        endif

        let filepath = expand('%:r') .. "_test.go"
    endif

    let filepath = fnameescape(filepath)

    execute "silent! bdelete!" filepath
    execute "vsplit" filepath
endfunc

autocmd vimrc FileType go command -buffer -nargs=? -complete=custom,TestComplete Test call CreateTestFile(<f-args>)
