vim.opt.number = true

function ToggleLineNumber()
    if vim.opt.number:get() == true and vim.opt.relativenumber:get() == false then
        vim.opt.relativenumber = true
    elseif vim.opt.relativenumber:get() == true and vim.opt.number:get() == true then
        vim.opt.number, vim.opt.relativenumber = false, false
    else
        vim.opt.number = true
    end
end

vim.keymap.set('n','<c-n>', ToggleLineNumber)
