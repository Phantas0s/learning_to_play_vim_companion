local function InsertTag(args)
    local substitute = string.format(
        [[%d,%ds#\v\<%s\>\zs(.{-})\ze\</%s\>#<%s>\1</%s>#g]],
        args.line1,
        args.line2,
        args.fargs[1],
        args.fargs[1],
        args.fargs[2],
        args.fargs[2]
    )

    vim.cmd(substitute)
end

vim.api.nvim_create_user_command('InsertTag', InsertTag, { nargs = '*', range = '%' })
