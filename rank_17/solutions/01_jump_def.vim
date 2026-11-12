function! JumpDef() abort
    let cword = expand('<cword>')
    let tags = taglist(printf('^%s$', cword))

    if !empty(tags)
        execute 'tag' cword
    else
        echo "No tag found, falling back to :grep"
        execute printf("silent grep! %s", cword) "| redraw!"
        copen
    endif
endfunction

nnoremap <leader>gd <cmd>call JumpDef()<cr>
