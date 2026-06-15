function RestorePosition()
    -- Lua tables begin with index 1.
    local line = vim.fn.getpos("'\"")[2]
    local col = vim.fn.getpos("'\"")[3]
    vim.fn.cursor(line, col)
end
