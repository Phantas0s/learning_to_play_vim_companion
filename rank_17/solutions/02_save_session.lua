vim.env.MYVIMDIR = vim.opt.runtimepath:get()[2] .. '/'

local function saveSession()
    local sessionDir = vim.env.MYVIMDIR .. 'sessions/'

    if vim.fn.isdirectory(sessionDir) == 0 then
        vim.fn.mkdir(sessionDir, 'p')
    end

    vim.cmd('mksession! ' .. sessionDir .. os.date('%Y%m%d%H%M') .. '.vim')
end

vim.api.nvim_create_augroup('AutoSession', { clear = true })
vim.api.nvim_create_autocmd('VimLeavePre', {
    group = 'AutoSession',
    callback = saveSession,
})
