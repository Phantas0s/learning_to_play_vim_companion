function CreateUndoNodes() abort
    let keys = ['.',',','!','?']
    for key in keys
        execute $'inoremap {key} <c-g>u{key}'
    endfor
endfunc
