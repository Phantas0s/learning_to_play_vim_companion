local function scratch(cmd)
    local output

    if cmd:sub(1, 1) == '!' then
        local shell_cmd = cmd:sub(2)
        if shell_cmd:find(' %') then
            shell_cmd = shell_cmd:gsub(' %', ' ' .. vim.fn.shellescape(vim.fn.expand('%:p')))
        end
        output = vim.fn.system(vim.fn.shellescape(shell_cmd))
    else
        output = vim.api.nvim_exec2(cmd, { output = true }).output
    end

    local lines = vim.split(output, '\n', { plain = true })
    if lines[#lines] == '' then
        table.remove(lines)
    end

    for _, info in ipairs(vim.fn.getwininfo()) do
        if vim.fn.getwinvar(info.winid, 'scratch') then
            pcall(vim.api.nvim_win_close, info.winid, true)
        end
    end

    vim.cmd('vnew')
    vim.fn.setwinvar(0, 'scratch', 1)
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'hide'
    vim.bo.swapfile = false

    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
end

vim.api.nvim_create_user_command('Scratch', function(opts)
    scratch(opts.args)
end, { nargs = 1 })
