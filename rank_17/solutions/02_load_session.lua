vim.env.MYVIMDIR = vim.opt.runtimepath:get()[2] .. '/'

local sessionDir = vim.env.MYVIMDIR .. 'sessions/'

if vim.fn.isdirectory(sessionDir) == 0 then
    vim.fn.mkdir(sessionDir, 'p')
end

local function loadLastSession()
    local sessions = vim.fn.glob(sessionDir .. '*.vim', false, true)

    if #sessions == 0 then
        vim.notify('No session available', vim.log.levels.INFO)
        return
    end

    vim.cmd('source ' .. sessions[#sessions])
end

vim.api.nvim_create_augroup('AutoSession', { clear = true })
vim.api.nvim_create_autocmd('VimLeavePre', {
    group = 'AutoSession',
    callback = function()
        vim.cmd('mksession! ' .. sessionDir .. os.date('%Y%m%d%H%M') .. '.vim')
    end,
})
vim.api.nvim_create_autocmd('VimEnter', {
    group = 'AutoSession',
    callback = loadLastSession,
})
