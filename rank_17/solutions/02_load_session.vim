" Neovim doesn't have $MYVIMDIR set by default
execute "let $MYVIMDIR='" .. split(&runtimepath, ',')[0] .. "/'"

let s:sessionDir = expand("$MYVIMDIR") .. "sessions/"

if !isdirectory(s:sessionDir)
    call mkdir(s:sessionDir, 'p')
endif

function! s:LoadLastSession() abort
    let sessions = sort(glob(s:sessionDir . '*.vim', 0, 1))

    if empty(sessions)
        echom "No session available"
        return
    endif

    " -1 is the last element of the list
    execute 'source' sessions[-1]
endfunction

augroup AutoSession
    autocmd!
    autocmd VimLeavePre * execute 'mksession!' s:sessionDir .. strftime('%Y%m%d%H%M') .. '.vim'
    autocmd VimEnter * call s:LoadLastSession()
augroup END
