function! s:HelpTags() abort
    let file = expand('%:p')
    let fname = fnamemodify(file, ":t")
    let tagFiles = printf("%s/tags", fnamemodify(file, ":h"))

    if !filereadable(tagFiles)
        echom "No tags found; run :PlugHelpTags first"
        return
    endif

    let entries = []
    " Read the files to force Vim to load all tag files
    for line in readfile(tagFiles)
        let parts = split(line, "\t")
        if len(parts) >= 3 && fnamemodify(parts[1], ":t") ==# fname
            call add(entries, #{
                \ filename: file,
                \ pattern:  parts[2][1:-2],
                \ text:     parts[0],
                \ })
        endif
    endfor

    if empty(entries)
        echom printf("No tags found for %s", fname)
        return
    endif

    call setloclist(0, entries)
    lopen
endfunction

autocmd vimrc Filetype help nnoremap <leader>t <cmd>call <sid>HelpTags()<cr>
