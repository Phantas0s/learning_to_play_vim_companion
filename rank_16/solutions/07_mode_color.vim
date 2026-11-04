function! s:ModeColor(mode) abort
    if a:mode == "i"
        highlight ModeMsg ctermfg=red ctermbg=none cterm=bold
    elseif a:mode == "r"
        highlight ModeMsg ctermfg=magenta ctermbg=none cterm=bold
    else
        highlight ModeMsg ctermfg=yellow ctermbg=none cterm=bold
    end
endfunction

augroup Mode
    autocmd!
    au InsertEnter * call s:ModeColor(v:insertmode)
    au InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=black cterm=bold
augroup END
