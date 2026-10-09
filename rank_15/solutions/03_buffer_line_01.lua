function BufferLine()
    local line = ""
    local totalBufs = vim.fn.bufnr('$')

    for bufIndex = 1, totalBufs do
        line = line .. bufIndex .. "-" .. vim.fn.bufname(bufIndex) .. " "
    end

    return line
end

vim.o.tabline = "%!v:lua.BufferLine()"
