function TabLine()
    local line = ''
    for i = 1, vim.fn.tabpagenr('$') do
        if i == vim.fn.tabpagenr() then
            line = line .. '%#TabLineSel#'
        else
            line = line .. '%#TabLine#'
        end
        line = line .. ' ' .. i .. ':'

        local buffers = vim.fn.tabpagebuflist(i)

        for _, val in ipairs(buffers) do
            if vim.api.nvim_get_option_value('modified', { buf = val }) then
                line = line .. '*'
                break
            end
        end

        local bufname = vim.api.nvim_buf_get_name(buffers[1])
        if bufname == '' then
            line = line .. ' [No Name]'
        else
            local list = vim.split(bufname, '/')
            line = line .. ' ' .. list[#list]
        end
    end

    return line
end

vim.o.tabline = '%!v:lua.TabLine()'
