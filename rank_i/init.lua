-- Disable the arrow keys (use kjhl instead, respectively)
vim.keymap.set('', '<up>', '<nop>')
vim.keymap.set('', '<down>', '<nop>')
vim.keymap.set('', '<left>', '<nop>')
vim.keymap.set('', '<right>', '<nop>')

-- Can copy-paste more easily from and to Vim
vim.opt.clipboard:append({'unnamedplus'})
