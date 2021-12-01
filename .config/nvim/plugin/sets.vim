" TextEdit might fail if hidden is not set.
set hidden
"
"  Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
"
"  " Give more space for displaying messages.
set cmdheight=2
"
"  Having longer updatetime (default is 4000 ms = 4 s leads to noticeable
") delays and poor user experience.
set updatetime=50
"
"" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Native settings
set nocompatible
filetype off                 


set spelllang=en
set tabstop=4 
set softtabstop=4
set shiftwidth=4 
set scrolloff=12
filetype indent on
set number
set ignorecase
set smartcase
set noswapfile
set incsearch
set noexpandtab
set nowrap
set signcolumn=yes
set nohlsearch
set noerrorbells


