command -nargs=* DiffOrig call DiffOrig(<f-args>)

function DiffOrig(...) abort
    if a:0 > 1
        throw "The function DiffOrig expects 0 or 1 argument"
    endif

    vertical new

    setlocal buftype=nofile nobuflisted
    " Set the filetype's value of the new buffer
    " using the value of the alternate's buffer filetype
    let &filetype = getbufvar('#', '&filetype')

    " If there is only one argument given
    if a:0 == 1
        " Run git show on the alternate buffer # using a git revision parameter
        " See https://git-scm.com/docs/gitrevisions
        execute 'silent read !git show ' .. a:1 .. ':./#'
        execute 'file git-' .. a:1
    else
        read #
    endif

    0delete _

    diffthis
    wincmd p
    diffthis
endfunction
