local function plugHelpTags()
    local dirs = {}
    for _, path in ipairs(vim.opt.packpath:get()) do
        local result = vim.fn.glob(string.format('%s/pack/*/*/*/doc', path), false, true)
        for _, d in ipairs(result) do
            table.insert(dirs, d)
        end
    end

    for _, d in ipairs(dirs) do
        vim.cmd('helptags ' .. vim.fn.fnameescape(d))
        vim.notify(string.format('Generated tags for %s', d), vim.log.levels.INFO)
    end
end

vim.api.nvim_create_user_command('PlugHelpTags', function()
    plugHelpTags()
end, { desc = 'Generate helptags for all plugins' })
