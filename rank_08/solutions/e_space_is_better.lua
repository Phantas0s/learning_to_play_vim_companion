function SpaceIsBetter(size)
    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.expandtab = true
    vim.cmd('retab! -indentonly')
end
