-- Automatic folds in files using tabs as indentation
local function foldTab(lineNr)
    local curLine = vim.fn.getline(lineNr)
    if curLine == "" then
        return '='
    else
        return string.len(string.match(curLine, '^\t*'))
    end
end

return {
    FoldTab = foldTab
}
