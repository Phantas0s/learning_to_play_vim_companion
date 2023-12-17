--------------
-- MAPPINGS --
--------------
-- All these keystrokes are non-recursive by default

vim.g.mapleader = " "

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

-- Delete the current line in insert mode
vim.keymap.set('i', '<c-d>', '<esc>ddi')
-- Open the vimrc in a new window
vim.keymap.set('n', '<f5>', ':vsplit $MYVIMRC<cr>')
-- Reload the vimrc directly from Vim
vim.keymap.set('n', '<f6>', ':source $MYVIMRC<cr>')

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

-- Disable the swap file for all buffers
-- See :help swap-file
vim.o.swapfile = false
