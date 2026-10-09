vim.api.nvim_create_user_command('OutputFunc', function(opts)
    local file = opts.fargs[1]

    local scan = vim.o.wrapscan
    local rega = vim.fn.getreg('a')
    vim.o.wrapscan = false

    vim.fn.system('touch ' .. file)
    vim.fn.system("echo '' > " .. file)

    vim.fn.setreg('a', '/^func\r:.write >> ' .. file .. '\r@a')

    for _, fname in ipairs(vim.fn.arglist()) do
        vim.cmd('edit ' .. fname)
        vim.fn.system(('echo == %s == >> %s'):format(fname, file))
        vim.cmd('normal! gg @a')
    end

    -- Restore
    vim.o.wrapscan = scan
    vim.fn.setreg('a', rega)
end, { nargs = 1 })
