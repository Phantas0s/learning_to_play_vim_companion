vim.api.nvim_create_autocmd({ 'BufWrite', 'BufRead' }, {
    pattern = '*.yaml.dist',
    command = 'setfiletype yaml',
})
