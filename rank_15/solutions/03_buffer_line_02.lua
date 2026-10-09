function BufferLine()
    local line = ""
    local totalBufs = vim.fn.bufnr('$')
    local currentBuf = vim.fn.bufnr()

    for bufIndex = 1, totalBufs do
        if bufIndex == currentBuf then
            line = line .. "["
        end

        line = line .. bufIndex .. "-" .. vim.fn.bufname(bufIndex)

        if bufIndex == currentBuf then
            line = line .. "] "
        else
            line = line .. " "
        end
    end

    return line
end

vim.o.tabline = "%!v:lua.BufferLine()"
