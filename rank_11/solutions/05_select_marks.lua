function SelectMarks(userCmd)
    vim.cmd(string.format("normal! `%sv`%s", userCmd.fargs[1], userCmd.fargs[2]))
end

vim.api.nvim_create_user_command('SelectMarks', SelectMarks, { nargs = '+' })
