-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
return {
	-- Utility plugin that other plugin use,
	{ "nvim-lua/plenary.nvim", lazy = true }, -- Telescope, ChatGPT
	{ "muniftanjim/nui.nvim",  lazy = true }, -- ChatGPT

	-- Fuzzy finder,
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = true,
		event = "VeryLazy",
	},

	-- pairs completer,
	{
		"windwp/nvim-autopairs",
		lazy = true,
		event = "InsertEnter",
		config = function()
			-- Auto pairs
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
			})
		end,
	},

	-- auto commenter
	{ "scrooloose/nerdcommenter", lazy = true, keys = { '<Plug>NERDCommenterToggle' } },

	-- UI to interact with git
	{ "tpope/vim-fugitive",       lazy = true, cmd = "Git" },

	-- better status line
	{
		"nvim-lualine/lualine.nvim",
		event = 'VeryLazy',
		config = function()
			-- Lualine
			require("lualine").setup({
				options = {
					icons_enabled = false,
					theme = "auto",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", { "filename", path = 1 } },
					lualine_c = { "diagnostics" },
					lualine_x = { "searchcount", "diff", "hostname" },
					lualine_y = { "filetype", "progress" },
					lualine_z = { "location" },
				},
			})
		end,
	},
}
