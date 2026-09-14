function SearchDigraphTable(userCmd)
    local tmp = "/tmp/digraphs"

    vim.cmd(string.format([[
        help digraph-table
        silent! bdelete! %s
        .+2,$-2write! %s
        quit
        vsplit %s
    ]], tmp, tmp, tmp))

    vim.opt_local.textwidth = 78
    vim.opt_local.tabstop = 8
    vim.opt_local.expandtab = false
    vim.opt_local.filetype = 'help'
    vim.opt_local.rightleft = false

    if (#userCmd.fargs) > 0 then
        vim.cmd(string.format("silent vimgrep /%s/ %s", userCmd.fargs[1], tmp))
    end
end

vim.api.nvim_create_user_command('Digraphs', SearchDigraphTable, { nargs = '?' })
