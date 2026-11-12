local function jumpTo()
    local ic = vim.opt.ignorecase:get()
    local sc = vim.opt.smartcase:get()
    vim.opt.ignorecase = true
    vim.opt.smartcase = false

    local cword = vim.fn.expand('<cword>')
    if cword == '' then
        vim.opt.ignorecase = ic
        vim.opt.smartcase = sc
        return
    end

    vim.cmd('redir => output')
    vim.cmd('silent! ilist ' .. cword)
    vim.cmd('redir END')

    local quickfix = {}
    local curFile = ''
    for _, line in ipairs(vim.split(vim.g.output, '\n')) do
        if line:match('^%S') then
            curFile = line
        elseif line:match('^%s*%d+:') then
            local lnum, text = line:match('^%s*%d+:%s+(%d+)%s+(.*)$')
            if lnum and curFile ~= '' then
                table.insert(quickfix, {
                    filename = vim.fn.fnamemodify(curFile, ':~:.'),
                    lnum = tonumber(lnum),
                    text = text,
                })
            end
        end
    end

    vim.fn.setqflist(quickfix)
    vim.cmd('copen')

    vim.opt.ignorecase = ic
    vim.opt.smartcase = sc
end

vim.keymap.set('n', '<leader>[I', jumpTo, { desc = 'Jump to word' })
