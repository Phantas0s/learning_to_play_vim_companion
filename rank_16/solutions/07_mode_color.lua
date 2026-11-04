function ModeColor(mode)
    if mode == "i" then
        vim.cmd("highlight ModeMsg ctermfg=red ctermbg=none cterm=bold")
    elseif mode == "r" then
        vim.cmd("highlight ModeMsg ctermfg=magenta ctermbg=none cterm=bold")
    else
        vim.cmd("highlight ModeMsg ctermfg=yellow ctermbg=none cterm=bold")
    end
end

vim.cmd([[
augroup Mode
    autocmd!
    au InsertEnter * lua ModeColor(vim.api.nvim_eval('v:insertmode'))
    au InsertLeave * hi ModeMsg ctermfg=yellow ctermbg=black cterm=bold
augroup END
]])
