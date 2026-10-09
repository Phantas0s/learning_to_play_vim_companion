function TabLine() abort
    let line = ""
    " Range through all tab pages open
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        if tabIndex == tabpagenr()
            let line .= "[" .. tabIndex
        else
            let line .= tabIndex
        endif

        let line .= "-"

        let buflist = tabpagebuflist(tabIndex)
        let bufname = ''
        " Range through each buffer of the tab page
        for b in buflist
            " Display the first buffer of each tab page in the tab line
            if bufname == ''
                let bufname = bufname(bufnr(b))
            endif
        endfor

        let line .= bufname

        if tabIndex == tabpagenr()
            let line .= "]"
        endif

        " If the current tab page is not the last one
        if tabIndex != tabpagenr('$')
            let line .= " | "
        endif
    endfor
    return line
endfunction

set tabline=%!TabLine()
