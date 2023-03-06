-- global variables
local g = vim.g
local map = require("utils").map

-- variables to modify netrw
g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_winsize = 25

-- variables to modify Vim Airline
g["airline_section_y"] = ""
g["airline_section_warning"] = ""
g["airline_section_z"] = "%p%%"

-- Fugitive remap
map("n", "<SPACE>gl", ":Git! log --decorate --oneline --graph --all<CR>")
map("n", "<SPACE>gs", ":G<CR>")

-- Telescope

-- Ctrl-p for searching for files
map("n", "<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
-- Ctrl-g for live grep
map("n", "<C-g>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
-- Space and t for all pickers in telescope
map("n", "<SPACE>t", "<cmd>lua require('telescope.builtin').builtin()<cr>")
-- Space and h for seaching through help
map("n", "<SPACE>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>")

-- Auto pairs
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

-- Mason LSP installer
local mason_settings = {
	ui = {
		-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
		border = "none",
	},

	pip = {
		-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
		-- and is not recommended.
		--
		-- Example: { "--proxy", "https://proxyserver" }
		install_args = {},
	},
	-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
	-- debugging issues with package installations.
	log_level = vim.log.levels.INFO,

	-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
	-- packages that are requested to be installed will be put in a queue.
	max_concurrent_installers = 4,
}
require("mason").setup(mason_settings)

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.eslint_d,
		null_ls.builtins.diagnostics.eslint_d,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.prettier_standard,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.yamlfmt,
		null_ls.builtins.formatting.dprint,
	},
})

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
})
