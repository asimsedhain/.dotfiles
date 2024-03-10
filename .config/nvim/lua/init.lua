-- configure lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ "scrooloose/nerdcommenter", lazy = true, event = "InsertEnter" },
	{ "tpope/vim-fugitive",       lazy = true, cmd = "Git" },
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

	-- Lualine,
	"nvim-lualine/lualine.nvim",

	-- colorscheme,
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
	{ "catppuccin/nvim",               lazy = true },

	-- Utility plugin that other plugin use,
	{ "nvim-lua/plenary.nvim",         lazy = true }, -- Telescope, ChatGPT
	{ "muniftanjim/nui.nvim",          lazy = true }, -- ChatGPT

	-- Fuzzy finder,
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" }, lazy = true, event = "VeryLazy" },

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

	-- LSP
	"neovim/nvim-lspconfig",
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
	-- LSP manager
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",

	-- LSP completion
	{ "hrsh7th/cmp-nvim-lsp",                lazy = true, event = "InsertEnter" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true, event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer",                  lazy = true, event = "InsertEnter" },
	{ "hrsh7th/cmp-path",                    lazy = true, event = "InsertEnter" },
	{ "hrsh7th/nvim-cmp",                    lazy = true, event = "InsertEnter" },

	-- ChatGPT
	{
		"jackMort/ChatGPT.nvim",
		lazy = true,
		cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", "ChatGPTCompleteCode" },
		dependencies = { "muniftanjim/nui.nvim" },
		config = function()
			-- ChatGPT
			require("chatgpt").setup({
				api_key_cmd = "security find-generic-password -s openai -w",
				chat = {
					welcome_message = "Start Asking....",
					loading_text = "Loading, please wait ...",
					question_sign = "🙋", -- 🙂
					answer_sign = "🤖", -- 🤖
					border_left_sign = "|",
					border_right_sign = "|",
					sessions_window = {
						active_sign = "🟩 ",
						inactive_sign = " ⬜️",
						current_line_sign = "►",
					},
				},
				popup_input = {
					prompt = " 🟢 ",
				},
				openai_params = {
					--model = "gpt-3.5-turbo",
					model = "gpt-4-turbo-preview",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 600,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					--model = "gpt-3.5-turbo",
					model = "gpt-4-turbo-preview",
					frequency_penalty = 0,
					presence_penalty = 0,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
			})
		end,
	},
}, {
	ui = {
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- require other modules

require("sets")
require("remap")
require("plugin")
require("color")
