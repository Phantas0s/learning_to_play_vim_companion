local function deleteTrailingWS()
    vim.cmd([[
        normal mz
        %s/\v\s+$//ge
        normal `z
    ]])
end

local function removeDirectories(table)
    for _, arg in ipairs(table.fargs) do
        local choice = vim.fn.confirm("Remove directory '" .. arg .. "'?", "&Yes\n&No")
        if choice == 1 then
            vim.fn.delete(arg, 'rf')
        end
    end
end

local function wordCount()
    if vim.api.nvim_get_option_value('filetype', { scope = "local" }) ~= "markdown" then
        return ""
    end

    return " " .. vim.fn.wordcount().words .. " words"
end

local function tabLine()
    vim.cmd([[
        highlight TabLineNum ctermfg=gray ctermbg=black cterm=none
        highlight TabLineNumSel ctermfg=red ctermbg=black cterm=bold
    ]])

    local line = ''
    for i = 1,vim.fn.tabpagenr('$') do
        if i == vim.fn.tabpagenr() then
            line = line .. '%#TabLineNumSel#'
        else
            line = line .. '%#TabLineNum#'
        end
        line = line .. ' ' .. i .. ':'

        local buffers = vim.fn.tabpagebuflist(i)
        for _,val in ipairs(buffers) do
            if vim.api.nvim_get_option_value('modified', { buf = val }) then
                line = line .. '*'
                break
            end
        end

        local list = vim.split(vim.api.nvim_buf_get_name(buffers[1]), '/')
        line = line .. list[#list]
    end

    return line
end

return {
    DeleteTrailingWS = deleteTrailingWS,
    RemoveDirectories = removeDirectories,
    WordCount = wordCount,
    TabLine = tabLine,
}
