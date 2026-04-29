-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins

return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
			vim.g.no_plugin_maps = true
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		branch = 'main',
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		config = function()
			require('nvim-treesitter').setup {
				-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = vim.fn.stdpath('data') .. '/site'
			}

			require("nvim-treesitter").install({
				"cpp",
				"lua",
				"rust",
				"go",
				"javascript",
				"json",
				"markdown",
				"toml",
				"tsx",
				"typescript",
				"python",
				"svelte",
				"css",
				"html",
			})
		end,
	},
}
