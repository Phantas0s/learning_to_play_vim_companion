local function helpTags()
    local file = vim.fn.expand('%:p')
    local fname = vim.fn.fnamemodify(file, ':t')
    local tagFiles = vim.fn.fnamemodify(file, ':h') .. '/tags'

    if vim.fn.filereadable(tagFiles) == 0 then
        vim.notify('No tags found; run :PlugHelpTags first', vim.log.levels.WARN)
        return
    end

    local entries = {}
    for _, line in ipairs(vim.fn.readfile(tagFiles)) do
        local parts = vim.split(line, '\t', { plain = true })
        if #parts >= 3 and vim.fn.fnamemodify(parts[2], ':t') == fname then
            table.insert(entries, {
                filename = file,
                pattern = parts[3]:sub(2, -2),
                text = parts[1],
            })
        end
    end

    if #entries == 0 then
        vim.notify(string.format('No tags found for %s', fname), vim.log.levels.WARN)
        return
    end

    vim.fn.setloclist(0, entries)
    vim.cmd('lopen')
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    callback = function()
        vim.keymap.set('n', '<leader>t', function()
            helpTags()
        end, { buffer = true, desc = 'Show tags for current help file' })
    end,
})
