function! PlugAdd(name) abort
    let plugin = split(a:name, "/")[1]
    execute "let $MYVIMDIR='" .. fnamemodify(expand("$MYVIMRC"), ":p:h") .. "'"
    let path = expand("${MYVIMDIR}pack/external/start/" .. plugin)

    if isdirectory(path)
        echo "Plugin already installed: " .. a:name
        return
    endif

    let result = system("git clone https://github.com/" .. a:name .. " " .. path)

    if v:shell_error != 0
        echoerr "Failed to install plugin: " .. result
    else
        echo "Plugin installed successfully: " .. a:name
    endif
endfunction

command! -nargs=1 PlugAdd call PlugAdd(<f-args>)
