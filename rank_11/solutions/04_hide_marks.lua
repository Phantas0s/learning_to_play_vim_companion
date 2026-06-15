function HideMarks()
    local places = {}
    for m=string.byte("a"),string.byte("z") do
        table.insert(places, { buffer = vim.api.nvim_get_current_buf(), group = "marks", id = m })
    end
    vim.fn.sign_unplacelist(places)
end
