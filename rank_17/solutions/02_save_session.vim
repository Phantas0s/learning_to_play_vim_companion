" Neovim doesn't have $MYVIMDIR set by default
execute "let $MYVIMDIR='" .. split(&runtimepath, ',')[0] .. "/'"

function! s:SaveSession() abort
    let s:sessionDir = expand("$MYVIMDIR") .. "sessions/"

    if !isdirectory(s:sessionDir)
        call mkdir(s:sessionDir, 'p')
    endif

    " Save the session
    execute 'mksession!' s:sessionDir .. strftime('%Y%m%d%H%M') .. '.vim'
endfunction

augroup AutoSession
    autocmd!
    autocmd VimLeavePre * call s:SaveSession()
augroup END

