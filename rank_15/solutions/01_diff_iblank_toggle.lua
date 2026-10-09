vim.api.nvim_create_user_command('DiffIBlankToggle', function()
    if vim.tbl_contains(vim.split(vim.o.diffopt, ','), 'iblank') then
        vim.opt.diffopt:remove('iblank')
    else
        vim.opt.diffopt:append('iblank')
    end
end, {})
