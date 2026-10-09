command -range Aprev call LoopArglist(-<line1>) | args
command -range Anext call LoopArglist(<line1>) | args

function LoopArglist(count) abort
    let argLen = argc(-1)
    if argLen == 0
        return
    endif

    " Current index in the arglist
    let currentIdx = argidx()
    " New index we want to move to
    let newIdx = currentIdx + a:count + 1

    " If further than the end of the list, loop at the beginning
    if newIdx > argLen
        let newIdx = newIdx - argLen
    endif

    " If further than the beginning of the list, loop at the end
    if newIdx <= 0
        let newIdx = newIdx + argLen
    endif

    execute 'silent argument' newIdx
endfunction
