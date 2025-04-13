local has = vim.fn.has
local system = vim.fn.system

local dark_mode = false

local dark_mode_theme = "catppuccin-mocha"

local light_mode_theme = "dawnfox"

---@param is_dark_mode boolean
local function set_theme(is_dark_mode)
	if is_dark_mode then
		vim.cmd("colorscheme " .. dark_mode_theme)
		vim.cmd("set bg=dark")
		dark_mode = true
	else
		dark_mode = false
		vim.cmd("set bg=light")
		vim.cmd("colorscheme " .. light_mode_theme)
	end
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "None" })
end

local function toggle_theme()
	set_theme(not dark_mode)
end

-- Creating a user command for toggling theme
vim.api.nvim_create_user_command("Bg", toggle_theme, {})

--- Synchronizes the Neovim theme with the system theme on Mac.
-- This function checks if the current system is macOS and then retrieves the 
-- system theme using a system command. It sets the theme in Neovim to dark or 
-- light based on the current macOS theme settings.
local function sync_theme_sys()
	if not has("mac") then
		print("Synchronization of theme with system only supported for Mac")
		return
	end

	local sys_theme = system("defaults read -g AppleInterfaceStyle")

	if string.find(sys_theme, "Dark") then
		set_theme(true)
	else
		set_theme(false)
	end
end

sync_theme_sys()
