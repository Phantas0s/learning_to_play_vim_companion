function! InstallPlugin(name) abort
    let plugin = split(a:name, "/")[1]
    let vimDir= fnamemodify(expand("$MYVIMRC"), ":p:h")
    let target = expand(printf('%s/pack/external/opt/%s', vimDir, plugin))


    if isdirectory(target)
        echomsg "Plugin already installed: " .. a:name
        return
    endif

    cd $HOME/dotfiles
    let result = system(printf('git submodule add https://github.com/%s %s/pack/external/opt/%s', a:name, vimDir, plugin))

    if v:shell_error != 0
        echoerr "Failed to install plugin: " .. result
    else
        echomsg printf("Plugin %s installed successfully", a:name)
    endif
    cd -
endfunction

command! -nargs=1 InstallPlugin call InstallPlugin(<q-args>)

function! UpdatePlugin() abort
    cd $HOME/dotfiles
    execute '!git submodule update --remote --merge'
    execute '!git pull --recurse-submodules'
    cd -
endfunction

command! UpdatePlugin call UpdatePlugin()

function general#RemovePlugin(name) abort
    cd $DOTFILES
    let plugin = split(a:name, "/")[1]
    let target = expand('$HOME/dotfiles/nvim/pack/external/opt/' .. plugin)
    let result = system("git rm " .. target)

    if v:shell_error != 0
        echoerr "Failed to remove plugin: " .. result
    else
        echomsg printf("Plugin %s removed successfully", a:name)
    endif
    cd -
endfunction

command! -nargs=1 RemovePlugin call general#RemovePlugin(<q-args>)
