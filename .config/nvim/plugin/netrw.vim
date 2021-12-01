" Tweaks for file tree
let g:netrw_banner = 0      " remove the banner at top
let g:netrw_altv=3          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


