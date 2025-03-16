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

function general#TabLine()
    " We assume we use a 256 colors terminal here
    highlight TabLineNum ctermfg=gray ctermbg=black cterm=none
    highlight TabLineNumSel ctermfg=red ctermbg=black cterm=bold

    let s = ''
    " Range through all tab pages open
    for i in range(tabpagenr('$'))
        let tabIndex = i+1
        " If the tab page is the current one, use a specific highlight
        " If not, use another highlight
        if tabIndex == tabpagenr()
            let s .= '%#TabLineNumSel#'
        else
            let s .= '%#TabLineNum#'
        endif

        let s .= ' ' . tabIndex . ':'

        " Loop through each buffer of the tab page
        let buflist = tabpagebuflist(tabIndex)
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
    endfor
    return s
endfunction

function general#Scratch(cmd)
    " save the redirection into a variable
    redir => output
    execute a:cmd
    redir END

    let output = split(output, "\n")

    if bufexists(bufname('scratch')) == v:false
        vnew scratch
        setlocal buftype=nofile bufhidden=hide noswapfile
    endif

    " Delete the scratch buffer content
    call deletebufline(bufnr('scratch'), 1, '$')
    call setbufline(bufnr('scratch'), 1, output)
endfunction
