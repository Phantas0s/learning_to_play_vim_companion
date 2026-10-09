function ArglistLine()
    local current = 1
    local line = ""
    local argLen = vim.fn.argc(-1)
    local argidx = vim.fn.argidx()
    while current <= argLen do
        line = line .. (current == argidx + 1 and '%#TabLineSel#' or '%#TabLine#')
        line = line .. current .. ":"
        line = line .. vim.fn.argv(current - 1) .. " "
        current = current + 1
    end
    return line
end

vim.api.nvim_create_autocmd('VimEnter', {
    group = group,
    pattern = '*',
    callback = function() vim.opt.showtabline = vim.fn.argc(-1) > 1 and 2 or 0 end
})

vim.opt.tabline = '%!v:lua.ArglistLine()'
