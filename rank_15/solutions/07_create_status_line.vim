function CreateStatusLine()
    augroup statusline
        autocmd!
    augroup END
    autocmd statusline ModeChanged *:no redrawstatus

    function! Mode() closure
        let m = mode(1)
        if m ==# "n"
            return "NORMAL"
        elseif m ==# "v"
            return "VISUAL"
        elseif m ==# "V"
            return "VISUAL LINE"
        elseif m ==# "\<c-v>"
            return "VISUAL BLOCK"
        elseif m ==# "i"
            return "INSERT"
        elseif m ==# "c"
            return "COMMAND-LINE"
        elseif m ==# "R"
            return "REPLACE"
        elseif m ==# "t"
            return "TERMINAL"
        elseif m ==# "no"
            return "OPERATOR PENDING"
        endif

        return ""
    endfunction

    let separator = " "

    " Left-hand side
    let sl = {mode -> mode != "" ? "--" .. Mode() .. "--" .. separator : ""}(Mode())
    let sl .= '%f'
    let sl .= separator
    let sl .= &l:modified ? "*" : "-"
    let sl .= &l:readonly ? separator : ""
    let sl .= '%r'
    let sl .= separator
    let sl .= '%y'

    " Right-hand side
    let sl .= '%='
    " Use a lambda (closure) for funsies
    let sl .= {branch -> branch != "" ?
                \ separator .. "[" .. branch .. "]" :
                \ ""}
                \(system("git rev-parse --abbrev-ref HEAD 2> /dev/null | tr -d '\n'"))
    let sl .= separator
    let sl .= (has_key(wordcount(), "visual_chars") ?
                \ wordcount().visual_chars :
                \ wordcount().chars)
                \ .. "chars"
    let sl .= separator
    let sl .= '%l/%L'
    let sl .=  separator
    let sl .= '%p%%'

    return sl
endfunction

set statusline=%!CreateStatusLine()
