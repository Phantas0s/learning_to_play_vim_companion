function SearchDigraphTable(...)
    let tmp="/tmp/digraphs"

    help digraph-table
    execute $"silent! bdelete! {tmp}"
    execute $".+2,$-2write! {tmp}"
    quit

    execute $"vsplit {tmp}"
    setlocal textwidth=78
    setlocal tabstop=8
    setlocal noexpandtab
    setlocal filetype=help
    setlocal norightleft

    if a:0 > 0
        silent execute $"vimgrep /{a:1}/ {tmp}"
    endif
endfunc

command! -nargs=? Digraphs call SearchDigraphTable(<f-args>)
