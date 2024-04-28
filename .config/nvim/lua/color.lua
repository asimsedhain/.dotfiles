local g = vim.g
local has = vim.fn.has
local system = vim.fn.system

g.gruvbox_contrast_light = "hard"
g.gruvbox_contrast_dark = "hard"

local dark_mode = false

local dark_mode_theme = "bamboo"

local light_mode_theme = "bamboo-light"

function ToggleTheme()
	if dark_mode then
		dark_mode = false
		vim.cmd("colorscheme " .. light_mode_theme)
	else
		dark_mode = true
		vim.cmd("colorscheme " .. dark_mode_theme)
	end
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })
end

-- Creating a user command for toggling theme
vim.api.nvim_create_user_command("Bg", ToggleTheme, {})

function SyncThemeWithSystem()
	if not has("mac") then
		print("Synchronization of theme with system only supported for Mac")
		return
	end

	local sys_theme = system("defaults read -g AppleInterfaceStyle")

	if string.find(sys_theme, "Dark") then
		vim.cmd("colorscheme " .. dark_mode_theme)
		dark_mode = true
	else
		dark_mode = false
		vim.cmd("colorscheme " .. light_mode_theme)
	end
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })
end

SyncThemeWithSystem()
