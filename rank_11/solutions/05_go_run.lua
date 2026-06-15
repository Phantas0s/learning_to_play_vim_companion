function GoRun(userCmd)
    vim.cmd('arg **/*.go')
    vim.cmd(string.format('argdo %s', userCmd.args))
end

vim.api.nvim_create_user_command('GoRun', GoRun, { nargs = 1, complete = "command" })
