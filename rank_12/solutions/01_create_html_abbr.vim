function CreateHTMLAbbr() abort
    let tags = ['body','div','p','section']
    for tag in tags
        execute $"iabbrev <buffer> <{tag}> <{tag}></{tag}><esc>F>a<c-o>call getchar()<cr>"
    endfor
    for i in range(1, 6)
        execute $"iabbrev <buffer> <h{i}> <h{i}></h{i}><esc>F>a<c-o>call getchar()<cr>"
    endfor
endfunc
