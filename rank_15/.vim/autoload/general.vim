function general#DeleteTrailingWS() abort
    normal mz
    %s/\v\s+$//ge
    normal `z
endfunc

function general#RemoveDirectories(...)
    for arg in a:000
        let choice = confirm("Remove directory '" .. arg .. "'?", "&Yes\n&No")
        if choice == 1
            call delete(arg, "rf")
        endif
    endfor
endfunction

function! general#Syn()
  for id in synstack(line("."), col("."))
    echo synIDattr(id, "name")
  endfor
endfunction

function general#WordCount() abort
    if (&ft!="markdown")
        return ""
    endif

    return wordcount()['words'] .. ' words'
endfunction

function! general#TabLine()
    let s = ''
    " Range through all tab pages open
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        " If the tab page is the current one, use a specific highlight
        " If not, use another highlight
        if tabIndex == tabpagenr()
            let s .= '%#TabLineNumSel#'
            let s .= ' ' . tabIndex
        else
            let s .= '%#TabLineNum#'
            let s .= ' ' . tabIndex
        endif
        " Loop through each buffer of the tab page
        let buflist = tabpagebuflist(i + 1)
        let bufname = ''
        let bufmodified = ''
        for b in buflist
            " Display the first buffer of each tab page in the tab line
            if bufname == ''
                let bufname = bufname(bufnr(b))
            endif
            " If one buffer is modified, display a star near the tab's index
            if getbufvar(b, "&modified")
                let bufmodified = '*'
            endif
        endfor
        let s .= bufmodified
        let s .= ' ' .. bufname
        let s .= '%#TabLine#'
    endfor
    return s
endfunction
