""""""""""""
" MAPPINGS "
""""""""""""

nmap <space> <nop>
let mapleader = "\<space>"

" Disable the arrow keys (use hjkl instead, respectively)
nmap <left> <nop>
nmap <down> <nop>
nmap <up> <nop>
nmap <right> <nop>

" Create a new tab
nnoremap <leader>t :tabnew<cr>
" Move to the next buffer
nnoremap <leader>nb :bnext<cr>
" Move to the next tab
nnoremap <leader>nt gt

" Y behave conceptually like D or C
nnoremap Y y$
" Open the vimrc in a new window
nnoremap <f5> :vsplit $MYVIMRC<cr>
" Reload the vimrc directly from Vim
nnoremap <f6> :source $MYVIMRC<cr>

"""""""""""
" OPTIONS "
"""""""""""

" Can copy-paste more easily from and to Vim
set clipboard+=unnamedplus

" Display line numbers
set number

" Use case insensitive search, except when using uppercases
set ignorecase
set smartcase

" Disable the swap file for all buffers
" See :help swap-file
set noswapfile
