--------------
-- MAPPINGS --
--------------

-- Disable the arrow keys (use hjkl instead, respectively)
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')

-------------
-- OPTIONS --
-------------

-- Can copy-paste more easily from and to Vim
vim.opt.clipboard:append({'unnamedplus'})

-- Display line numbers
vim.o.number = true

-- Use case insensitive search, except when using uppercases
vim.o.ignorecase = true
vim.o.smartcase = true
