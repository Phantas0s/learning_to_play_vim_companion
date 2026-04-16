function SpaceIsBetter(size) abort
    let &shiftwidth=a:size
    let &tabstop=a:size
    set expandtab
    retab! -indentonly
endfunction
