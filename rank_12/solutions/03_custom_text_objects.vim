function CustomTextObjects() abort
    let chars = [ '_', '.', '<bar>', '/', '`' ]
    for char in chars
        for mode in [ 'xnoremap', 'onoremap' ]
            execute $'{mode} i{char} :<c-u>silent! normal! f{char}F{char}lvt{char}<cr>'
            execute $'{mode} a{char} :<c-u>silent! normal! f{char}F{char}vf{char}<cr>'
        endfor
    endfor
endfunc
