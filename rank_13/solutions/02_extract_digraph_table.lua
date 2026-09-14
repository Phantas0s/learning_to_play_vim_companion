function ExtractDigraphTable()
    vim.cmd([[
        help digraph-table
        silent! bdelete! /tmp/digraphs
        .+2,$-2write! /tmp/digraphs
        quit
        vsplit /tmp/digraphs
    ]])

    vim.opt_local.textwidth = 78
    vim.opt_local.tabstop = 8
    vim.opt_local.expandtab = false
    vim.opt_local.filetype = 'help'
    vim.opt_local.rightleft = false
end

vim.api.nvim_create_user_command('Digraphs', ExtractDigraphTable, { })
