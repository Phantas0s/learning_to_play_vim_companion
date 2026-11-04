local function Inspect()
    for _, id in ipairs(vim.fn.synstack(vim.fn.line('.'), vim.fn.col('.'))) do
        local synGroup = vim.fn.synIDattr(id, 'name')
        if synGroup ~= '' then
            vim.cmd('syntax list ' .. synGroup)
        end

        local linkedGroup = vim.fn.synIDattr(
            vim.fn.synIDtrans(vim.fn.synID(vim.fn.line('.'), vim.fn.col('.'), 0)), 'name')
        if linkedGroup ~= '' then
            vim.cmd('highlight ' .. linkedGroup)
        end
    end
end

vim.api.nvim_create_user_command('Inspect', Inspect, {})
