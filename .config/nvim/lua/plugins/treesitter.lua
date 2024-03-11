-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins

return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		dependencies = { "nvim-treesitter" },
		event = "InsertEnter",
		config = function()
			-- Context
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
				multiline_threshold = 2, -- Maximum number of lines to show for a single context
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "VeryLazy",
		config = function()
			-- NVIM tree-sitter for highlighting
			require("nvim-treesitter.configs").setup({
				-- A list of parser names, or "all"
				ensure_installed = {
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
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				auto_install = true,
				-- List of parsers to ignore installing (for "all")
				ignore_install = {},
				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					-- `false` will disable the whole extension
					enable = true,
					-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
					-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
					-- the name of the parser)
					-- list of language that will be disabled
					disable = {},
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				modules = {},
			})
		end,
	},
}
