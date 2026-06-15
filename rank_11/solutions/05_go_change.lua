function GoChange(userCmd)
    local currentBuffer = vim.fn.bufname()

    local buffers = vim.split(vim.fn.execute("ls"), '\n')
    local oldBufferList = {}
    -- Save all buffer IDs into the list oldBufferList
    for _, i in ipairs(buffers) do
        local bufID = vim.fn.split(i)[1]
        if bufID ~= nil then
            table.insert(oldBufferList, bufID)
        end
    end

    -- Add all Go files into the arglist
    vim.cmd.arg('**/*.go')
    -- Run the Ex command given as argument on all Go files and write them if they were modified
    -- Output and errors are never displayed
    vim.cmd(string.format("silent! argdo execute '%s' | update", userCmd.args))

    -- Come back to the current buffer
    vim.cmd.buffer(currentBuffer)

    local newBufferList = vim.split(vim.fn.execute("ls"), '\n')
    -- Wipe all buffers which were not open
    for _, i in ipairs(newBufferList) do
        local bufID = vim.fn.split(i)[1]
        if bufID ~= nil and vim.fn.index(oldBufferList, bufID) < 0 then
            vim.cmd.bwipe(bufID)
        end
    end
end

vim.api.nvim_create_user_command('GoChange', GoChange, { nargs = 1, complete = "command" })
