function TabLine() abort
    let s = ''
    " Range through all tab pages open
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        if tabIndex == tabpagenr()
            let s .= '%#TabLine#'
        else
            let s .= '%#TabLineSel#'
        endif

        let s .= ' ' . tabIndex . ':'

        let buflist = tabpagebuflist(tabIndex)
        let bufname = ''
        let bufmodified = ''
        " Range through each buffer of the tab page
        for b in buflist
            " Display the first buffer of each tab page in the tab line
            if bufname == ''
                let bufname = bufname(bufnr(b))
                if bufname == ''
                    let bufname = '[No Name]'
                endif
            endif
            " If one buffer is modified, display a star near the tab's index
            if getbufvar(b, "&modified")
                let bufmodified = '*'
            endif
        endfor

        let s .= bufmodified
        let s .= ' ' .. bufname
    endfor
    return s
endfunction

set tabline=%!TabLine()
