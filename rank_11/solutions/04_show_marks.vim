function ShowMarks() abort
    let marks = range(char2nr('a'), char2nr('z'))
    let signs = []
    let places = []
    for m in marks
        let line = line("'" .. nr2char(m))
        " line is not equal to 0 if the mark is set
        if line != 0
            call add(signs, {"name": m, "text": nr2char(m), "texthl": "Error"})
            " bufname() without argument return the current buffer
            call add(places, {"buffer": bufname(), "group": "marks", "id": m, "lnum": line, "name": m })
        endif
    endfor
    call sign_define(signs)
    call sign_placelist(places)
endfunc
