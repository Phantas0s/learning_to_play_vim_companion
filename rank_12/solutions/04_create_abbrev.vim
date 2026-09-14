function s:PromptExpandAbbr(abbr, exp, mode) abort
    if a:mode !=? 'i' && a:mode !=? 'c' && a:mode !=? getcmdtype()
        return a:abbr
    endif

    let p = confirm($'Expand "{a:abbr}"?', "&Yes\n&No")
    return p == 1 ? a:exp : a:abbr
endfunction

function s:CreateAbbrev(abbr, expansion, mode)
    let m = a:mode !=? 'i' ? 'c' : 'i'
    execute $"{m}abbrev <expr> {a:abbr} <sid>PromptExpandAbbr('{a:abbr}', '{a:expansion}', '{a:mode}')"
endfunc

call <sid>CreateAbbrev('@@', 'mail@mail.com', 'i')
call <sid>CreateAbbrev('@@', 'mail@mail.com', ':')
