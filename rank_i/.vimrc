"
" MAPPINGS
"

" Disable the arrow keys (use kjhl instead, respectively)
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"
" OPTIONS
"

" Can copy-paste more easily from and to Vim
set clipboard+=unnamedplus

" No compatibility with Vi
set nocompatible

" Display line numbers
set number

" Enhanced completion in command-line mode
set wildmenu

" Syntax highlighting
syntax on

" Enable filetype, indentation, plugin
filetype plugin indent on

" Always display the status bar
set laststatus=2
