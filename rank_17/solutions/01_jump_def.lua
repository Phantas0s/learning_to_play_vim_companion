local function jumpDef()
    local cword = vim.fn.expand('<cword>')
    local tags = vim.fn.taglist('^' .. cword .. '$')

    if #tags > 0 then
        vim.cmd('tag ' .. cword)
    else
        vim.notify('No tag found, falling back to :grep', vim.log.levels.INFO)
        vim.cmd('silent! grep! ' .. cword .. ' | redraw!')
        vim.cmd('copen')
    end
end

vim.keymap.set('n', '<leader>gd', jumpDef, { desc = 'Jump to definition' })
