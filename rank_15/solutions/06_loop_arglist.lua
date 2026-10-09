local function loopArglist(count)
    local argLen = vim.fn.argc(-1)
    if argLen == 0 then
        return
    end

    local currentIdx = vim.fn.argidx()
    local newIdxg = currentIdx + count + 1

    if newIdxg > argLen then
        newIdxg = newIdxg - argLen
    end

    if newIdxg <= 0 then
        newIdxg = newIdxg + argLen
    end

    vim.cmd('silent argument ' .. newIdxg)
end

vim.api.nvim_create_user_command('Aprev', function(args)
    local count = args.count > 0 and args.count or 1
    loopArglist(-count)
    vim.cmd('args')
end, { count = true })

vim.api.nvim_create_user_command('Anext', function(args)
    local count = args.count > 0 and args.count or 1
    loopArglist(count)
    vim.cmd('args')
end, { count = true })
