local shigh = vim.api.nvim_create_augroup('shigh', { clear = true })

vim.api.nvim_create_autocmd({ 'CmdlineEnter' }, {
    group = shigh,
    pattern = { "\\?", '/' },
    command = 'set hlsearch incsearch',
})

vim.api.nvim_create_autocmd({ 'CmdlineLeave' }, {
    group = shigh,
    pattern = { "\\?", '/' },
    command = 'set nohlsearch noincsearch',
})

vim.api.nvim_create_autocmd({ 'InsertEnter' }, {
    group = shigh,
    pattern = '*',
    command = 'set nohlsearch',
})
