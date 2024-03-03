--------------
-- MAPPINGS --
--------------
-- All these mappings are non-recursive by default

vim.keymap.set('n', ' ', '<nop>')
vim.g.mapleader = ' '

-- Disable the arrow keys (use hjkl instead, respectively)
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')

-- Create a new tab
vim.keymap.set('n', '<leader>t', ':tabnew<cr>')
-- Move to the next buffer
vim.keymap.set('n', '<leader>nb', ':bnext<cr>')
-- Move to the next tab
vim.keymap.set('n', '<leader>nt', 'gt')

-- Open the vimrc in a new window
vim.keymap.set('n', '<f5>', ':vsplit $MYVIMRC<cr>')
-- Reload the vimrc directly from Vim
vim.keymap.set('n', '<f6>', ':source $MYVIMRC<cr>')

-- Move from window to window using CTRL-{direction} instead of CTRL-w {direction}
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')

-------------
-- OPTIONS --
-------------

-- Can copy-paste more easily from and to Vim
vim.opt.clipboard:append({'unnamedplus'})

-- Display line numbers
vim.opt.number = true

-- Use case insensitive search, except when using uppercases
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable the swap file for all buffers
-- See :help swap-file
vim.opt.swapfile = false
