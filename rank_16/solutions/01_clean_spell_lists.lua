local function CleanSpellLists(regex)
    local re = vim.regex(regex)

    for _, fname in ipairs(vim.split(vim.fn.globpath(vim.o.rtp, 'spell/*.add'), '\n')) do
        if vim.fn.filewritable(fname) == 1 then
            local lines = vim.fn.readfile(fname)
            local kept = {}
            for _, line in ipairs(lines) do
                if not re:match_str(line) then
                    table.insert(kept, line)
                end
            end
            if #kept < #lines then
                vim.fn.writefile(kept, fname)
                vim.cmd('silent! mkspell! ' .. vim.fn.fnameescape(fname))
                print(('Processed %s (%d lines removed)'):format(fname, #lines - #kept))
            end
        end
    end
end

vim.api.nvim_create_user_command('CleanSpellLists', function(opts)
    CleanSpellLists(opts.args)
end, {
    nargs = 1,
    desc = 'Remove lines matching a regex from all spell .add files',
})

