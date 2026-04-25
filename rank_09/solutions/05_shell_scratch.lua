function ShellScratch(cmd, escape)
    if type(escape) ~= "boolean" then
        error("The second argument must be a boolean")
    end

    local buf = vim.fn.bufadd("scratch")
    local winid = vim.fn.bufwinid(buf)

    if winid >= 0 then
        vim.api.nvim_set_current_win(winid)
    else
        vim.cmd.sbuffer(buf)
    end

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "hide"
    vim.bo.swapfile = false

    vim.cmd(string.format("%%delete_ | silent read !%s", vim.fn.shellescape(cmd, escape)))
end

