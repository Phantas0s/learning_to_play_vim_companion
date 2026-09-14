function CustomTextObjects()
    local chars = { '_', '.', '<bar>', '/', '`' }
    for _, char in ipairs(chars) do
        for _, mode in ipairs({ 'x', 'o' }) do
            vim.keymap.set(mode, 'i' .. char, string.format(':<c-u>silent! normal! f%sF%slvt%s<cr>', char, char, char), { silent = true })
            vim.keymap.set(mode, 'a' .. char, string.format(':<c-u>silent! normal! f%sF%svf%s<cr>', char, char, char, { silent = true }))
        end
    end
end
