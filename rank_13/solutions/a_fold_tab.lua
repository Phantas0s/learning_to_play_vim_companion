function FoldTab(lineNr)
    local curLine = vim.fn.getline(lineNr)
    local prevLine = vim.fn.getline(lineNr - 1)
    local curIndentTabNr = string.len(string.match(curLine, '^\t*'))
    local prevIndentTabNr = string.len(string.match(prevLine, '^\t*'))

    if curLine == "" then
        if prevIndentTabNr > 0 then
            return '='
        end
    elseif curIndentTabNr > 0 then
        return curIndentTabNr + 1
    else
        return 1
    end
end

vim.opt.foldexpr = "v:lua.FoldTab(v:lnum)"
