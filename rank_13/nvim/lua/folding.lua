-- Automatic folds in files using tabs as indentation
local function foldTab(line_num)
    local curLine = vim.fn.getline(line_num)
    if curLine == "" then
        return '='
    else
        return string.len(string.match(curLine, '^\t*'))
    end
end

return {
    FoldTab = foldTab
}
