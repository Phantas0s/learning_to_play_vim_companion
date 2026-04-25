" Insert the output of a shell command in a scratch buffer
function ShellScratch(cmd, escape) abort
    if a:escape isnot v:true && a:escape isnot v:false
        throw "The second argument must be true or false"
    endif

    let buf = bufadd('scratch')
    let winid = bufwinid(buf)
    if winid >= 0
        call win_gotoid(winid)
    else
        execute 'sbuffer' buf
    endif

    setlocal buftype=nofile bufhidden=hide noswapfile
    execute printf('%delete_ | silent read !%s', shellescape(a:cmd, a:escape))
endfunction
