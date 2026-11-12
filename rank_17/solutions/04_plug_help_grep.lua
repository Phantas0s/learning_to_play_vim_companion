local function plugHelpGrep(pattern)
    local tagFiles = {}
    for _, path in ipairs(vim.opt.packpath:get()) do
        local result = vim.fn.glob(string.format('%s/pack/*/*/*/doc/tags', path), false, true)
        for _, f in ipairs(result) do
            table.insert(tagFiles, f)
        end
    end

    if #tagFiles == 0 then
        vim.notify('No tag files found; run :PlugHelpTags first', vim.log.levels.WARN)
        return
    end

    local entries = {}
    for _, tagsfile in ipairs(tagFiles) do
        local dir = vim.fn.fnamemodify(tagsfile, ':h')
        for _, line in ipairs(vim.fn.readfile(tagsfile)) do
            local parts = vim.split(line, '\t', { plain = true })
            if #parts >= 3 and vim.fn.match(parts[1], pattern) >= 0 then
                table.insert(entries, {
                    filename = dir .. '/' .. parts[2],
                    pattern = parts[3]:sub(2, -2),
                    text = parts[1],
                })
            end
        end
    end

    if #entries == 0 then
        vim.notify(string.format('No tags matching %s', pattern), vim.log.levels.WARN)
        return
    end

    vim.fn.setqflist(entries)
    vim.cmd('copen')
end

vim.api.nvim_create_user_command('PlugHelpGrep', function(opts)
    plugHelpGrep(opts.args)
end, { nargs = 1, desc = 'Grep plugin help tags' })
