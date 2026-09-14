local foldLevel = 0

function FoldMarkdownSection(lineNr)
    local getHeaderLevel = function(line)
        local match = string.match(line, '^#+')
        if match then
            return string.len(match)
        else
            return 0
        end
    end

    local curLine = vim.fn.getline(lineNr)
    local curHeaderLevel = getHeaderLevel(curLine)

    local nextLine = vim.fn.getline(lineNr + 1)
    local nextHeaderLevel = getHeaderLevel(nextLine)

    if curHeaderLevel > 0 then
        foldLevel = curHeaderLevel
    elseif nextHeaderLevel <= foldLevel and nextHeaderLevel > 0 then
        foldLevel = foldLevel - 1
    end

    return foldLevel
end

vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.FoldMarkdownSection(v:lnum)'
