-- Create a scratch buffer and insert the Git status
function GitStatus()
    -- Create a buffer 'git_status', or return it if it already exists
    local buf = vim.fn.bufadd('git_status')
    -- Get the window displaying that buffer
    local winid = vim.fn.bufwinid(buf)

    -- If a window displays that buffer, move the cursor inside
    -- If not, create a new split window and edit that buffer
    if winid >= 0 then
        vim.api.nvim_set_current_win(winid)
    else
        vim.cmd.sbuffer(buf)
    end

    -- See :help scratch-buffer
    vim.bo.buftype = 'nofile'
    vim.bo.bufhidden = 'hide'
    vim.bo.swapfile = false

    vim.cmd([[%delete_ | silent read !git status --short]])
end
