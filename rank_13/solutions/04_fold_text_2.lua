function FoldText()
    local firstLine
    if vim.o.foldmethod == 'marker' then
        firstLine = vim.fn.substitute(vim.fn.getline(vim.v.foldstart), [[\v^.*\{{3}\ze.*$]], '{...}', '')
    else
        firstLine = vim.fn.getline(vim.v.foldstart)
    end

    local countLines = vim.v.foldend - vim.v.foldstart + 1

    -- Add padding the size of the window minus the size of the line,
    -- and the size of the count of lines.
    local padding = vim.fn.winwidth(0) - string.len(firstLine) - string.len(countLines)

    -- Adjust the padding depending on the size of the right hand size column.
    if vim.o.number or vim.o.relativenumber then
        padding = padding - vim.o.numberwidth
    end

    if vim.o.foldcolumn then
        padding = padding - vim.o.foldcolumn
    end

    return string.format('%s%s%s', firstLine, string.rep(' ', padding), countLines)
end

vim.opt.foldtext="v:lua.FoldText()"
