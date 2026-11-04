function CleanSpellLists(regex) abort
    for fname in split(globpath(&rtp, "spell/*.add"), "\n")
        if filewritable(fname)
            let fname = fnameescape(fname)
            silent execute "tab split " .. fname
            echo "Processing" fname
            execute "silent! g/".. a:regex .. "/d"
            silent update
            close
            execute "silent! mkspell!" fname
            echo "Processed " .. fname
        endif
    endfor
endfunction

command -nargs=1 CleanSpellLists call CleanSpellLists(<q-args>)
