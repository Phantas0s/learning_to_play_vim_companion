vim.opt_local.formatprg='jq .'

vim.keymap.set('n', '<localleader>m', [[<cmd>%s/\_s//g<cr>]], {buffer = true})
