function GoFind()
    local handle = io.popen("find . -name '*.go'")
    if handle ~= nil then
        local files = handle:read("*a")
        handle:close()
        -- Create a new quickfix list
        vim.fn.setqflist({})
        for _,f in pairs(vim.fn.split(files)) do
            -- Add to the newly created quickfix list
            vim.fn.setqflist({{ filename=f, lnum=1, lcol=1, text=f }}, "a")
        end
    end
end
