function! TagStackToQuickfix() abort
    let tagStack = gettagstack()
    let entries = []

    if empty(tagStack.items)
        echo "The tag stack is empty."
        return
    endif

    for tag in uniq(tagStack.items)
        let entry = {
            \ "filename": expand("#" .. tag.bufnr),
            \ "lnum": tag.from[1],
            \ "col": tag.from[2],
            \ "text": tag.tagname,
            \ "valid": 1
            \ }
        call add(entries, entry)
    endfor

    call setqflist(entries)
    copen
endfunction

command QTagStack call TagStackToQuickfix()
