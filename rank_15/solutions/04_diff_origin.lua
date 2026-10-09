vim.api.nvim_create_user_command('DiffOrig', function(opts)
    local args = opts.fargs
    if #args > 1 then
        error("The function DiffOrig expects 0 or 1 argument")
    end

    vim.cmd('vertical new')

    vim.bo.buftype = 'nofile'
    vim.bo.buflisted = false

    local altBuf = vim.fn.bufnr('#')
    vim.bo.filetype = vim.bo[altBuf].filetype

    if #args == 1 then
        local rev = args[1]
        vim.cmd('silent! read !git show ' .. rev .. ':./#')
        vim.cmd('file git-' .. rev)
    else
        vim.cmd('read #')
    end

    vim.cmd('0delete _')

    vim.cmd('diffthis')
    vim.cmd('wincmd p')
    vim.cmd('diffthis')
end, { nargs = '*' })
