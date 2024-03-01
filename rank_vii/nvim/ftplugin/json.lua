vim.opt_local.formatprg='jq .'

vim.keymap.set('n', '<leader>m', [[<cmd>%s/[ \s\r\n]//g<cr>]], {buffer = true})
