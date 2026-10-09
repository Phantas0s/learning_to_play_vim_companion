local algorithms = { 'myers', 'minimal', 'patience', 'histogram' }

vim.api.nvim_create_user_command('DiffAlgo', function(opts)
    local algo = opts.fargs[1]
    -- Remove all algorithm: values from diffopt
    for _, a in ipairs(algorithms) do
        vim.opt.diffopt:remove('algorithm:' .. a)
    end
    -- Add the specified one if valid
    if vim.tbl_contains(algorithms, algo) then
        vim.opt.diffopt:append('algorithm:' .. algo)
    end
end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
    return algorithms
    end,
})
