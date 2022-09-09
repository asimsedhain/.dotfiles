"gurvbox theme setting
let g:gruvbox_contrast_light = "hard"
let g:gruvbox_contrast_dark = "hard"


let s:global_background = "dark"
let s:global_light_colorscheme = "onehalflight"
let s:global_dark_colorscheme = "onehalfdark"

function! SetBgCs(temp_bg, temp_cs)
	execute "set background=" . a:temp_bg
	execute "colorscheme " a:temp_cs
	let s:global_background = a:temp_bg
	let g:airline_theme=a:temp_cs
endfunction

function! BgToggleSol()
	if (s:global_background ==? "light")
		call SetBgCs("dark",s:global_dark_colorscheme)
	else
		call SetBgCs("light",s:global_light_colorscheme)
	endif
endfunction


function! BgSync()
	if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
		call SetBgCs("dark",s:global_dark_colorscheme)
	else
		call SetBgCs("light",s:global_light_colorscheme)
	endif
endfunction


command! -nargs=0 Bg :call BgToggleSol()
call BgSync()
