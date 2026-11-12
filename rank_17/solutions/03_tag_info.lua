local function tagInfo()
    local cword = vim.fn.expand('<cword>')
    local tags = vim.fn.taglist('^' .. cword .. '$')

    if #tags == 0 then
        vim.notify('No tag found', vim.log.levels.INFO)
        return
    end

    local lines = { string.format("Tags for '%s' (%d found):", cword, #tags) }
    for i, tag in ipairs(tags) do
        table.insert(lines, string.format('#%d | Name: %s | Kind: %s | File: %s', i, tag.name, tag.kind, tag.filename))
    end

    vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end

vim.keymap.set('n', 'ti', tagInfo, { desc = 'Show tag info' })
