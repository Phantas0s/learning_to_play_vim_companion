-------------
-- PLUGINS --
-------------
-- You can install vim-plug by running in your shell:
--
-- sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
--       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--
--  Ex command to install the plugins listed here:
-- :PlugUpdate

local Plug = vim.fn['plug#']
vim.call('plug#begin')
    Plug 'tpope/vim-surround'
vim.call('plug#end')

---------------
-- FUNCTIONS --
---------------

local customFunc = require("functions")

------------------
-- AUTOCOMMANDS --
------------------

-- Autocommand group deleting all its autocommands each time this file is sourced
local vimrc = vim.api.nvim_create_augroup('vimrc', { clear = true })

-- Delete all trailing whitespaces before writing any buffer
vim.api.nvim_create_autocmd({ 'BufWrite' }, {
    group = vimrc,
    pattern = '*',
    callback = customFunc.customDeleteTrailingWS
})

--------------
-- MAPPINGS --
--------------
-- All these mappings are non-recursive by default

vim.keymap.set('n', ' ', '<nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Replace indentations using tabs with spaces
vim.keymap.set('n', '<leader>ds', customFunc.customDeleteTrailingWS)

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
-- Delete the current buffer without closing the current window
vim.keymap.set('n', '<leader>dd', '<cmd>bprevious <bar> bdelete! #<cr>')

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

-- To find files in the following directories:
-- Directory of the current file "."
-- All directories and sub-directories of the global working directory "**"
vim.opt.path = { '.', '**', ',' }

vim.opt.grepprg = 'grep -n $*'
-- If ripgrep is installed, use it for :grep and :grepadd
if vim.fn.executable('rg') == 1 then
    vim.opt.grepprg = 'rg --vimgrep --smart-case $*'
end

