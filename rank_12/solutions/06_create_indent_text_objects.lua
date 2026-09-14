function SelectIndent(around)
    local currentLine = '.'
    local startIndent = vim.fn.indent(vim.fn.line(currentLine))
    local blankLine = function(line) return string.match(vim.fn.getline(line), [[^%s*$]]) end

    if blankLine(currentLine) then
        return
    end

    if vim.v.count > 0 then
        startIndent = startIndent - vim.o.shiftwidth * (vim.v.count - 1)
        if startIndent < 0 then
            startIndent = 0
        end
    end

    local prevLine = vim.fn.line(currentLine) - 1
    while prevLine > 0 and (blankLine(prevLine) or vim.fn.indent(prevLine) >= startIndent) do
        vim.cmd('-')
        prevLine = vim.fn.line(currentLine) - 1
    end
    if around then
        vim.cmd('-')
    end

    vim.cmd('normal! 0V')

    local nextLine = vim.fn.line(currentLine) + 1
    local lastLine = vim.fn.line('$')
    while nextLine <= lastLine and (blankLine(nextLine) or vim.fn.indent(nextLine) >= startIndent) do
        vim.cmd('+')
        nextLine = vim.fn.line(currentLine) + 1
    end
    if around then
        vim.cmd('+')
    end
end

function CreateIndentTextObject()
    local modes = {'o', 'x'}
    for _, mode in ipairs(modes) do
        vim.keymap.set(mode, 'ii', ':<c-u>lua SelectIndent(false)<cr>', { silent = true })
        vim.keymap.set(mode, 'ai', ':<c-u>lua SelectIndent(true)<cr>', { silent = true })
    end
end
