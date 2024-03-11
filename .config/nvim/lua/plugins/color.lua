-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		config = function()
			-- kanagawa does not highlight borders properly
			require("kanagawa").setup({
				overrides = function(colors)
					local theme = colors.theme
					return {
						-- have sharp borders
						WinSeparator = { fg = theme.ui.fg },

						-- give sharp borders to telescope
						TelescopePromptBorder = { fg = theme.ui.fg, bg = "None" },
						TelescopeResultsBorder = { fg = theme.ui.fg, bg = "None" },
						TelescopePreviewBorder = { fg = theme.ui.fg, bg = "None" },
					}
				end,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			-- rose-pine is a pain and does not come with highlight_groups for git
			require("rose-pine").setup({
				highlight_groups = {
					DiffAdded = { fg = "pine" },
					DiffRemoved = { fg = "love" },
					DiffChange = { fg = "rose" },
					DiffDelete = { fg = "love" },
					DiffText = { fg = "rose" },
				},
			})
		end,
	},
	{ "catppuccin/nvim", lazy = true },
}
