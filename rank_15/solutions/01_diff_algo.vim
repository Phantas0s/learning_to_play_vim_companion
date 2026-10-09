command -nargs=1 -complete=custom,s:AllDiffAlgo DiffAlgo call s:DiffAlgo(<f-args>)

" Return all possible algorithms for completion
function s:AllDiffAlgo(...) abort
    let algorithms = ['myers','minimal','patience','histogram']
    return join(algorithms, "\n")
endfunction

function s:DiffAlgo(algo) abort
    let algorithms = split(s:AllDiffAlgo(), "\n")

    " Delete all algorithms potentially added as value
    for a in algorithms
        if &diffopt =~ 'algorithm:' .. a
            execute 'set diffopt-=algorithm:' .. a
        endif
    endfor

    " If argument is in the list of algorithms
    if index(algorithms, a:algo) >= 0
        execute 'set diffopt+=algorithm:' .. a:algo
    endif
endfunction
