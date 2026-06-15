function CreateHTMLAbbr()
    local tags = {"body", "div", "p", "section"}
    for _, tag in ipairs(tags) do
        -- ia to create an abbreviation in insert mode
        vim.keymap.set("ia", "<" .. tag .. ">", string.format("<%s></%s><esc>F>a<c-o>call getchar()<cr>", tag, tag), { buffer = true})
    end

    for i = 1, 6 do
        vim.keymap.set("ia", "<h" .. i .. ">", string.format("<h%d></h%d><esc>F>a<c-o>call getchar()<cr>", i, i), { buffer = true})
    end
end
