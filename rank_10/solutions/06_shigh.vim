augroup shigh
    autocmd!
augroup END

autocmd shigh CmdlineEnter /,\? set hlsearch incsearch
autocmd shigh CmdlineLeave /,\? set nohlsearch noincsearch
autocmd shigh InsertEnter * set nohlsearch
