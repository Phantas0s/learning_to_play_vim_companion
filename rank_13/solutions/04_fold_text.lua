function FoldText()
    local firstLine
    if vim.o.foldmethod == 'marker' then
        firstLine = vim.fn.substitute(vim.fn.getline(vim.v.foldstart), [[\v^.*\{{3}\ze.*$]], '{...}', '')
    else
        firstLine = vim.fn.getline(vim.v.foldstart)
    end

    local countLines = vim.v.foldend - vim.v.foldstart + 1

    return string.format("%s %s",firstLine, countLines)
end

vim.opt.foldtext="v:lua.FoldText()"
