function! TagInfo()
    let cword = expand("<cword>")
    let tags = taglist(printf('^%s$', cword))

    if empty(tags)
        echo "No tag found."
        return
    endif

    echom printf("Tags for '%s' (%d found):\n", cword, len(tags))
    for i in range(len(tags))
        let tag = tags[i]
        echom printf("#%d | Name: %s | Kind: %s | File: %s",
            \ i + 1,
            \ tag["name"],
            \ tag["kind"],
            \ tag["filename"])
    endfor
endfunction

nnoremap ti <cmd>call TagInfo()<cr>
