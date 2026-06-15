function BdAll(userCmd)
    local buffers = vim.split(vim.fn.execute("ls"), '\n')

    for _, i in ipairs(buffers) do
        local bufID = vim.fn.split(i)[1]
        -- If it's not the current buffer, delete it
        if bufID ~= nil and bufID ~= tostring(vim.fn.bufnr()) then
            -- see :help vim.cmd() and for options :help nvim_parse_cmd()
            vim.cmd.bdelete({ args = { bufID }, bang = userCmd.bang, mods = { emsg_silent = true } })
        end
    end
end

vim.api.nvim_create_user_command('BdAll', BdAll, { bang = true })
