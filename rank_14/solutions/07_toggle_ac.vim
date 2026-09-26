let s:ac_enabled = v:false

function ToggleAC()
    let chars = map(range(char2nr('a'),char2nr('z')),'nr2char(v:val)')
    let chars = add(chars, '.')

    if s:ac_enabled
        for l in chars
            execute $"iunmap {l}"
        endfor
        let s:ac_enabled = v:false
    else
        for l in chars
            execute $"inoremap {l} {l}<c-n>"
        endfor
        let s:ac_enabled = v:true
    endif
endfunction

command ToggleAC call ToggleAC()
