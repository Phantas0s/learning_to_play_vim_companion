function! s:PlugHelpTags() abort
    let dirs = globpath(&packpath, "pack/*/*/*/doc", v:false, v:true)
    for d in dirs
        execute printf("helptags %s", fnameescape(d))
        echom printf("Generated tags for %s", d)
    endfor
endfunction

command! PlugHelpTags call s:PlugHelpTags()
