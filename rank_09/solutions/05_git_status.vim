" Create a scratch buffer and insert the Git status
function GitStatus() abort
    " Create a buffer 'git_status', or return it if it already exists
    let buf = bufadd('git_status')
    " Get the window displaying that buffer
    let winid = bufwinid(buf)
    " If a window displays that buffer, move the cursor inside
    " If not, create a new split window and edit that buffer
    if winid >= 0
        call win_gotoid(winid)
    else
        execute 'sbuffer' buf
    endif

    " See :help scratch-buffer
    setlocal buftype=nofile bufhidden=hide noswapfile

    %delete_ | silent read !git status --short
endfunction
