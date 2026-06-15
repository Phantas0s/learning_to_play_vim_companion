function ShowMarks()
    local signs = {}
    local places = {}
    for m=string.byte("a"),string.byte("z") do
        local line = vim.fn.line("'" ..  string.char(m))
        -- line is not equal to 0 if the mark is set
        if line ~= 0 then
            table.insert(signs, { name = m, text = string.char(m), texthl = "Error" })
            table.insert(places, { buffer = vim.api.nvim_get_current_buf(), group = "marks", id = m, lnum = line, name = m })
        end
    end
    vim.fn.sign_define(signs)
    vim.fn.sign_placelist(places)
end
