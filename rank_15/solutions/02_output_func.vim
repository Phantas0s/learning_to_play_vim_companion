command -nargs=1 OutputFunc call s:OutputFunc(<f-args>)

function s:OutputFunc(file)
    let scan = &wrapscan
    " Save the content of register "a" into a variable
    let rega = getreg('a')
    set nowrapscan

    " Create and delete everything in the file
    call system("touch ".. a:file)
    call system("echo '' > " .. a:file)

    " Save our macro in register a
    let @a = '/^func:.write >> '.. a:file ..'@a'
    execute 'argdo let fname = expand("%")'
                \ '| call system(printf("echo == %s == >>' a:file '", fname))'
                \ '| normal gg @a'

    " Restore wrapscan and register "a" values
    let &wrapscan = scan
    let @a = rega
endfunction
