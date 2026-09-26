function s:SetErrorFile(arg) abort
    let s:cmdbang = "cfile " .. a:arg .. " | copen"
    let s:cmd = "cgetfile " .. a:arg
endfunction

function s:TryErrorFormat(format, bang = '') abort
    if exists("s:cmd") == v:true && exists("s:cmdbang") == v:true
        let &errorformat=a:format
        if a:bang ==# ''
            execute s:cmd
        else
            execute s:cmdbang
        endif
        return
    endif
    echom "You need to run :SetErrorFile[!] {file} first"
endfunction

command -nargs=1 -complete=file SetErrorFile call s:SetErrorFile(<f-args>)
command -bang -nargs=1 TryErrorFormat call s:TryErrorFormat(<q-args>,'<bang>')
