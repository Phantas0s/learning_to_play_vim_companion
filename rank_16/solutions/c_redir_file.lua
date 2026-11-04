vim.api.nvim_create_user_command("RedirFile", function(opts)
    local file = opts.fargs[1]
    local cmd = {}
    for i = 2, #opts.fargs do cmd[i - 1] = opts.fargs[i] end
    local output = vim.fn.execute(table.concat(cmd, " "), "silent")
    local f = io.open(file, "a")
    if f then
        f:write(output)
        f:close()
    end
end, { nargs = "*", complete = "command" })
