function s:ExtractDigraphTable(pattern)
    " Save the digraph table into a file
    let tmp = "/tmp/digraphs"
    if filereadable(tmp) == v:false
        help digraph-table
        call search("char")
        execute $"silence .,$-2write! {tmp}"
        quit
    endif

    let digraphs = []
    let headers = []
    let firstLine = v:true

    " Transform the digraph table into a list of list.
    let table = readfile(tmp)
    for line in table
        if firstLine
            let headers = split(line, "\t")
            let firstLine = v:false
            continue
        endif

        let items = []
        for item in split(line, "\t")
            call add(items, item)
        endfor
        call add(digraphs, items)
    endfor

    " Go through the list to try to match the pattern.
    let match = []
    for digraph in digraphs
        for item in digraph
            if match(item, a:pattern) != -1
                let match = add(match, digraph)
            endif
        endfor
    endfor

    " Display the result of the search.
    if empty(match)
        echo "No match found"
    else
        echo join(headers, "\t")
        for m in match
            echo join(m, "\t")
        endfor
    endif
endfunc

command! -nargs=1 Digraphs call s:ExtractDigraphTable(<f-args>)
