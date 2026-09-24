function QuicklistSigns()
    local errorTypes = {'e','w', 'i', 'n'}
    -- We delete every quickfix sign created previously
    vim.fn.sign_unplace('quickfixEntry')
    for _, item in pairs(vim.fn.getqflist()) do
        -- We need our quickfix entry valid
        if item.valid then
            local signName = 'q-' .. item.type
            local sign = '->'
            -- If the error type is part of our recognized error types,
            -- we display this error type instead of "->"
            if vim.fn.index(errorTypes, string.lower(item.type)) >= 0 then
                sign = string.upper(item.type)
            end
            vim.fn.sign_define(signName, {text = sign, texthl = 'NONE', linehl = 'NONE'})
            vim.fn.sign_place(item.lnum, 'quickfixEntry', signName, item.bufnr, {lnum = item.lnum})
        end
    end
end

local quickfix = vim.api.nvim_create_augroup("quickfix", { clear = true })

vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = quickfix,
    pattern = '*',
    callback = QuicklistSigns
})
