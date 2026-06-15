function DeleteTrailingWS()
    local cursor = vim.fn.getcurpos()
    vim.cmd([[%s/\v\s+$//ge]])
    -- Lua tables begin with the index 1
    vim.fn.cursor(cursor[2], cursor[3])
end
