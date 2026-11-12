local function plugHelp(plugin)
    local name = vim.fn.fnamemodify(plugin, ':t')

    local files = {}
    for _, path in ipairs(vim.opt.packpath:get()) do
        local result = vim.fn.glob(string.format('%s/pack/*/*/%s/doc/*', path, name), false, true)
        for _, f in ipairs(result) do
            table.insert(files, f)
        end
    end

    if #files == 0 then
        vim.notify(string.format('No help file for the plugin %s', plugin), vim.log.levels.WARN)
        return
    end

    for _, file in ipairs(files) do
        local buf = vim.fn.bufadd(file)
        vim.fn.bufload(buf)
        vim.bo[buf].buftype = 'help'
        vim.bo[buf].bufhidden = 'unload'
        vim.bo[buf].buflisted = false
        vim.bo[buf].swapfile = false
        vim.bo[buf].readonly = true
        vim.bo[buf].modifiable = false
        vim.bo[buf].modified = false
        vim.bo[buf].filetype = 'help'
    end

    vim.cmd('split ' .. vim.fn.fnameescape(files[1]))
end

local function completePlugins(arglead, _, _)
    local dirs = {}
    for _, path in ipairs(vim.opt.packpath:get()) do
        local result = vim.fn.glob(string.format('%s/pack/*/*/*', path), false, true)
        for _, d in ipairs(result) do
            table.insert(dirs, d)
        end
    end

    local names = vim.tbl_map(function(d)
        return vim.fn.fnamemodify(d, ':t')
    end, dirs)
    table.sort(names)

    local seen = {}
    local unique = {}
    for _, n in ipairs(names) do
        if not seen[n] then
            seen[n] = true
            table.insert(unique, n)
        end
    end

    return vim.tbl_filter(function(n)
        return n:sub(1, #arglead) == arglead
    end, unique)
end

vim.api.nvim_create_user_command('PlugHelp', function(opts)
    plugHelp(opts.args)
end, {
    nargs = 1,
    complete = completePlugins,
    desc = 'Open plugin help',
})
