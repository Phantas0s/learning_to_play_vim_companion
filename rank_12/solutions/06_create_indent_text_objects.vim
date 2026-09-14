function! IndentTextObject(around)
    let currentLine = "."
    let startIndent = indent(line(currentLine))

    " See :help lambda
    let BlankLine = { line -> match(getline(line), "^[[:space:]]*$") == -1 ? v:false : v:true }

    if BlankLine(currentLine)
        return
    endif

    if v:count > 0
        let startIndent -= &shiftwidth * (v:count - 1)
    endif

    " Move up until we are at the top of the buffer
    " or until the indentation is less than the starting one
    let prevLine = line(currentLine) - 1
    while prevLine > 0 && (BlankLine(currentLine) || indent(prevLine) >= startIndent)
        normal! k
        let prevLine = line(currentLine) - 1
    endwhile

    if a:around
        normal! k
    endif

    " Begin visual selection linewise
    normal! 0V

    " Move down until we are at the bottom of the buffer
    " or until the indentation is less than the starting one
    let nextLine = line(currentLine) + 1
    let lastLine = line("$")
    while nextLine <= lastLine && (BlankLine(nextLine) || indent(nextLine) >= startIndent)
        normal! j
        let nextLine = line(currentLine) + 1
    endwhile

    if a:around
        normal! j
    endif
endfunction

function CreateIndentTextObject() abort
    let modes = ["o", "x"]
    for mode in modes
        execute $"{mode}noremap <silent>ii :<c-u>call IndentTextObject(v:false)<cr>"
        execute $"{mode}noremap <silent>ai :<c-u>call IndentTextObject(v:true)<cr>"
    endfor
endfunc
