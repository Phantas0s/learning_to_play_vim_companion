function TabLine()
    local line = ""
    local totalTabs = vim.fn.tabpagenr('$')
    local currentTab = vim.fn.tabpagenr()

    for tabIndex = 1, totalTabs do
        if tabIndex == currentTab then
            line = line .. "[" .. tabIndex
        else
            line = line .. tabIndex
        end

        line = line .. "-"

        local buflist = vim.fn.tabpagebuflist(tabIndex)
        local bufname = ""

        for _, b in ipairs(buflist) do
            if bufname == "" then
                bufname = vim.fn.bufname(vim.fn.bufnr(b))
            end
        end

        line = line .. bufname

        if tabIndex == currentTab then
            line = line .. "]"
        end

        if tabIndex ~= totalTabs then
            line = line .. " | "
        end
    end

    return line
end

vim.o.tabline = "%!v:lua.TabLine()"
