function! s:PlugHelp(plugin) abort
    " Get the name of the plugin, in case its syntax is {user}/{plugin}
    let name = fnamemodify(a:plugin, ":t")

    " Get all files in the directory "doc" of the plugins
    let files = globpath(&packpath, printf("pack/*/*/%s/doc/*", name), v:false, v:true)
    if empty(files)
        echo printf("No help file for the plugin %s", a:plugin)
        return
    endif

    for file in files
        let buf = bufadd(file)
        call bufload(buf)
        " Set local options correctly for the buffer
        " to mimic a help buffer opened when running :help
        call setbufvar(buf, "&buftype", "help")
        call setbufvar(buf, "&bufhidden", "unload")
        call setbufvar(buf, "&buflisted", v:false)
        call setbufvar(buf, "&swapfile", v:false)
        call setbufvar(buf, "&readonly", v:true)
        call setbufvar(buf, "&modifiable", v:false)
        call setbufvar(buf, "&modified", v:false)
        call setbufvar(buf, "&filetype", "help")
    endfor

    execute "split" fnameescape(files[0])
endfunction

function! s:CompletePlugins(ArgLead, CmdLine, CursorPos) abort
    " Get absolute paths of all plugins
    let dirs = globpath(&packpath, "pack/*/*/*", v:false, v:true)
    let names = uniq(sort(map(dirs, {_, d -> fnamemodify(d, ":t")})))
    return join(filter(names, {_, n -> n =~# printf("^%s", a:ArgLead)}), "\n")
endfunction

command! -nargs=1 -complete=custom,s:CompletePlugins PlugHelp call s:PlugHelp(<f-args>)
