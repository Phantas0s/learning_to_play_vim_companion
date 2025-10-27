"""""""""""""
" FUNCTIONS "
"""""""""""""
" {{{

" All the functions are written in Lua in another file.
let customFunc = luaeval('require("functions")')

" }}}

"""""""""""""""""
" USER COMMANDS "
"""""""""""""""""
" {{{

command! -nargs=+ -complete=dir Mkdir !mkdir -p <args>

" The Lua function expect a table with key "fargs"
" which has itself a table as value with each argument.
" See :help lua-guide-commands-create
command! -nargs=+ -complete=dir Rmdir call customFunc.RemoveDirectories({'fargs': split(<q-args>)})

command! -nargs=1 Scratch silent call customFunc.Scratch({"fargs": [<f-args>]})

" }}}

""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""
" {{{

augroup vimrc
    autocmd!
augroup END

autocmd vimrc BufWrite * call customFunc.DeleteTrailingWS()

autocmd vimrc BufEnter $MYVIMRC setlocal foldmethod=marker

" }}}

""""""""""""
" MAPPINGS "
""""""""""""
" {{{

nmap <space> <nop>
let mapleader = "\<space>"
let maplocalleader = "\<space>"

" Disable the arrow keys (use hjkl instead, respectively)
nmap <left> <nop>
nmap <down> <nop>
nmap <up> <nop>
nmap <right> <nop>

" Create a new tab
nnoremap <leader>t <cmd>tabnew<cr>
" Move to the next buffer
nnoremap <leader>nb <cmd>bnext<cr>
" Move to the next tab
nnoremap <leader>nt gt
" Delete the current buffer without closing the current window
nnoremap <leader>dd <cmd>bprevious <bar> bdelete! #<cr>

" Y behave conceptually like D or C
nnoremap Y y$
" Open the vimrc in a new window
nnoremap <f5> <cmd>vsplit $MYVIMRC<cr>
" Reload the vimrc directly from Vim
nnoremap <f6> <cmd>source $MYVIMRC<cr>

" Move from window to window using CTRL-{direction} instead of CTRL-w {direction}
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Toggle relative line numbers
nnoremap <c-n> <cmd>set relativenumber!<cr>
inoremap <c-n> <cmd>set relativenumber!<cr>

" }}}

"""""""""""""""
" STATUS LINE "
"""""""""""""""
" {{{

let &statusline='%r'                               "Read Only flag
let &statusline.=' %t'                             "Filename
let &statusline.=' %m'                             "Modified Flag
let &statusline.=' Buf %n'                         "Buffer Number
let &statusline.=' %{customFunc.WordCount()}'      "Word count

set tabline=%!customFunc.TabLine()

" }}}

"""""""""""
" OPTIONS "
"""""""""""
" {{{

" Can copy-paste more easily from and to Vim
set clipboard+=unnamedplus

" Display absolute line numbers
set number

" Use case insensitive search, except when using uppercases
set ignorecase
set smartcase

" Highlight the matches after a search
set hlsearch

" Disable the swap file for all buffers
" See :help swap-file
set noswapfile

" Add directory of the current file "."
" Add all directories and sub-directories of the global working directory "**"
set path=.,**,,

let &grepprg='grep -n $*'
" If ripgrep is installed, use it for :grep and :grepadd
if executable('rg')
    let &grepprg='rg --vimgrep --smart-case $*'
endif

" Save undo trees in files
set undofile
set undolevels=10000 " Maximum number of changes that can be undone (default 1000)

" }}}
