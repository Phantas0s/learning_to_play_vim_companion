" Create mapping for a specific visual mode type.
" For the argument 'model', use one of the strings: 'charwise', 'linewise', 'blockwise'; default is 'charwise'
function Xnoremap(mode, mapping, keystroke) abort
    let m = 'v'

    if a:mode ==# 'linewise'
        let m = 'V'
    elseif a:mode ==# "blockwise"
        let m = '<c-v>'
    endif

    execute printf('xnoremap <expr> %s
      \ mode() ==# "%s" ? "%s" : ""',
      \ a:mapping, m, escape(a:keystroke,'"'))
endfunction

