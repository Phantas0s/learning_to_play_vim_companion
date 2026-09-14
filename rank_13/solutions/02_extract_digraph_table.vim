function ExtractDigraphTable()
    help digraph-table
    silent! bdelete! /tmp/digraphs
    .+1,$-2write! /tmp/digraphs
    quit

    vsplit /tmp/digraphs
    setlocal textwidth=78
    setlocal tabstop=8
    setlocal noexpandtab
    setlocal filetype=help
    setlocal norightleft
endfunc

command Digraphs call ExtractDigraphTable()
