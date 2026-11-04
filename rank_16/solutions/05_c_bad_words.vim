function s:CBadWords() abort
    " Save the original cursor position and spell option
    let originPos = getpos('.')
    let originSpell = &spell

    let badWordList = []

    " Go through each line of the buffer
    for lineNum in range(1 , line('$'))
        " Move the cursor to the line
        call cursor(lineNum, 1)

        " Get all bad words on the line
        while 1
            " Move to the next bad word
            let badWordInfo = spellbadword()
            if !empty(badWordInfo[0])
                " Add the current bad word to the list
                " and move the cursor past it
                call add(badWordList,
                    \ { 'bufnr': bufnr('%'),
                    \ 'lnum': line('.'), 'col': col('.'),
                    \ 'text': badWordInfo[0] }
                \ )
                silent! normal! W
            else
                " No bad words on the line left, we move to the next one
                break
            endif
        endwhile
    endfor

    " Restore cursor position and spell option
    let &spell = originSpell
    call setpos('.', originPos)

    " Build and open the quickfix list
    call setqflist([], 'r', { 'title': 'Bad Spelled Words', 'items': badWordList }) | copen
endfunction

command CBadWords call s:CBadWords()
