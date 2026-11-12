function! s:PlugHelpGrep(pattern) abort
    let tagsfiles = globpath(&packpath, "pack/*/*/*/doc/tags", 0, 1)
    if empty(tagsfiles)
        echom "No tag files found; run :PlugHelpTags first"
        return
    endif

    let entries = []
    for tagsfile in tagsfiles
        let dir = fnamemodify(tagsfile, ":h")
        for line in readfile(tagsfile)
            let parts = split(line, "\t")
            if len(parts) >= 3 && parts[0] =~# a:pattern
                call add(entries, #{
                    \ filename: printf("%s/%s", dir, parts[1]),
                    \ pattern:  parts[2][1:-2],
                    \ text:     parts[0],
                    \ })
            endif
        endfor
    endfor

    if empty(entries)
        echom printf("No tags matching %s", a:pattern)
        return
    endif

    call setqflist(entries)
    copen
endfunction

command! -nargs=1 PlugHelpGrep call s:PlugHelpGrep(<f-args>)
