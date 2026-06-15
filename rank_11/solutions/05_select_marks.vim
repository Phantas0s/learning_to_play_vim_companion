function SelectMarks(...) abort
    execute feedkeys($"`{a:1}v`{a:2}")
endfunc

command -nargs=+ SelectMarks call SelectMarks(<f-args>)
