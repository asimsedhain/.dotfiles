local has = vim.fn.has
local system = vim.fn.system

local dark_mode = false

local dark_mode_theme = "catppuccin-mocha"

local light_mode_theme = "bamboo-light"

---@param is_dark_mode boolean
local function setTheme(is_dark_mode)
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

function ToggleTheme()
	setTheme(not dark_mode)
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
		setTheme(true)
	else
		setTheme(false)
	end
end

SyncThemeWithSystem()
