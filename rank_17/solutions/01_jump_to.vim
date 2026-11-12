function! JumpTo() abort
    let ic = &ignorecase
    let sc = &smartcase
    set ignorecase
    set nosmartcase

    let cword = expand('<cword>')

    redir => output
    silent execute "ilist" cword
    redir END

    let lines = split(output, '\n')
    let curfile = ''
    let quickfix = []
    for line in lines
        if line =~ '^\S'
            let file = matchstr(line, '\v^\S+')
        elseif line =~ '\v^\s*\d+'
            let valid = matchlist(line, '\v^\s*(\d+):\s*(\d+)\s*(.*)')
            call add(quickfix, #{
                \ filename: file,
                \ lnum: valid[2],
                \ text: valid[3]
                \ })
        endif
    endfor

    call setqflist(quickfix)
    copen

    let &ignorecase = ic
    let &smartcase = sc
endfunction

nnoremap <leader>[I <cmd>call JumpTo()<cr>
