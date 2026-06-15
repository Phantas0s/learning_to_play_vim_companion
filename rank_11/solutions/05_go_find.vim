function GoFind() abort
    let files = split(system("find . -name '*.go'"))
    let list = []
    for f in files
        call add(list, printf("%s:1:%s", f, f))
    endfor
    cexpr list
endfunc

command GoFind call GoFind()
