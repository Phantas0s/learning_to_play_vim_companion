function HideMarks() abort
    let marks = range(char2nr('a'), char2nr('z'))
    let places = []
    for m in marks
        call add(places, {"buffer": bufname(), "group": "marks", "id": m})
    endfor
    call sign_unplacelist(places)
endfunc
