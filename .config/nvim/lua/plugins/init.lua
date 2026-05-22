local map = require("utils").map
local has = vim.fn.has

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
		config = function()
			-- Ctrl-p for searching for files
			map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>",
				{ desc = "Ctrl-p for searching for files" })
			-- <Space>-p for searching for files without ignore hidden files
			map("n", "<SPACE>p", "<cmd>lua require('telescope.builtin').find_files({hidden= true})<cr>",
				{ desc = "<Space>-p for searching for files without ignore hidden files" })
			-- Ctrl-g for live grep
			map("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { desc = "Ctrl-g for live grep" })
			-- <Space>-t for all pickers in telescope
			map("n", "<SPACE>t", "<cmd>lua require('telescope.builtin').builtin()<cr>",
				{ desc = "<Space>-t for all pickers in telescope" })
			-- Space-h for seaching through help
			map("n", "<SPACE>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>", {
				desc =
				"<Space>-h for seaching through help"
			})
		end
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
	{
		"scrooloose/nerdcommenter",
		lazy = true,
		event = 'VeryLazy',
		config = function()
			-- ctrl+/ for commenting
			if has("macunix") then
				map("n", "÷", "<Plug>NERDCommenterToggle",
					{ noremap = false, desc = "Option + / to toggle line comment" })
				map("v", "÷", "<Plug>NERDCommenterToggle<CR>gv",
					{ noremap = false, desc = "Option + / to toggle line comment" })
				map("i", "÷", "<C-c><Plug>NERDCommenterToggle",
					{ noremap = false, desc = "Option + / to toggle line comment" })
			elseif has("win64") then
				map("n", "<C-_>", "<Plug>NERDCommenterToggle", { noremap = false, desc = "Toggle line comment" })
				map("v", "<C-_>", "<Plug>NERDCommenterToggle<CR>gv", { noremap = false, desc = "Toggle line comment" })
				map("i", "<C-_>", "<C-c><Plug>NERDCommenterToggle", { noremap = false, desc = "Toggle line comment" })
			end
		end
	},

	-- UI to interact with git
	{
		"tpope/vim-fugitive",
		lazy = true,
		cmd = "Git",
		config = function()
			map("n", "<SPACE>gl", ":Git log --decorate --oneline --graph --all<CR>",
				{ desc = "<Space>gl to show git log" })
			map("n", "<SPACE>gs", ":Git<CR>", { desc = "<Space>gs to show git status" })
			vim.cmd("cnorea Gf Git fetch")
			vim.cmd("cnorea Gpull Git pull")
			vim.cmd("cnorea Gsw Git switch")
			vim.cmd("cnorea Gb Git branch")
		end

	},

	-- Better netrw
	{
		'stevearc/oil.nvim',
		opts = {
			view_options = {
				show_hidden = true
			},
			use_default_keymaps = false,
		},
		config = function()
			require("oil").setup(
				{

					view_options = {
						show_hidden = true
					},
					use_default_keymaps = false,
					keymaps = {
						["<CR>"] = "actions.select",
						["<C-l>"] = "actions.refresh",
					}
				}
			)

			map("n", "<C-\\>", "<cmd>Oil<cr>", { desc = "<Ctrl-\\ for openning the current directory in Oil" })
		end,
	},

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
	}
}
