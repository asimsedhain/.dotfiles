local config = require("lspconfig")
local chatgpt = require("chatgpt")
local keys = require("utils").keys
local removeElement = require("utils").removeElement
local api = vim.api

-- Auto pairs
require("nvim-autopairs").setup({
	disable_filetype = { "TelescopePrompt", "vim" },
})

-- Set diagnostics to show source
vim.diagnostic.config({
	virtual_text = {
		source = false,
	},
	float = {
		source = "always",
	},
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
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.prettier_standard,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.yamlfmt,
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
	modules = {},
})

-- LSP servers and settings
local lsp_servers = {
	pyright = {},
	ruff_lsp = {},
	gopls = {},
	html = {},
	jsonls = {},
	tsserver = {},
	eslint = {},
	marksman = {},
	rust_analyzer = {
		["rust-analyzer"] = {
			-- enable clippy on save
			check = {
				command = "clippy",
			},
			diagnostics = {
				enable = true,
			},
		},
	},
	svelte = {},
	cssls = {
		css = {
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
	tailwindcss = {},
	clangd = {},
	lua_ls = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "runtime_path" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

local lsp_servers_to_install = removeElement(keys(lsp_servers), "rust_analyzer") -- use the local rust_analyzer installed by rustup installed of allowing mason to install it.
require("mason-lspconfig").setup({ ensure_installed = lsp_servers_to_install })

-- nvim-cmp completion engine
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
cmp.setup({
	preselect = cmp.PreselectMode.None,
	window = {
		completion = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete()
			end
		end, { "i" }),
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.complete()
			end
		end, { "i" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp", max_item_count = 6 },
	}, { { name = "nvim_lsp_signature_help", max_item_count = 1 } }, {
		{
			name = "buffer",
			max_item_count = 3,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
	}, { { name = "path", keyword_length = 3, max_item_count = 3 } }),
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

	-- user command for formating and code actions
	-- formates with null-ls first and then with other LSP
	api.nvim_buf_create_user_command(bufnr, "Format", function()
		vim.lsp.buf.format(nil, nil, { "null-ls" })
	end, {})

	api.nvim_buf_create_user_command(bufnr, "Enext", vim.diagnostic.goto_next, {})
	api.nvim_buf_create_user_command(bufnr, "Eprev", vim.diagnostic.goto_prev, {})

	-- code actions shortcut
	api.nvim_buf_create_user_command(bufnr, "Caction", function()
		vim.lsp.buf.code_action()
	end, {})

	-- highlighting on cursorhold
	if client.server_capabilities.document_highlight then
		api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			desc = "Highlight symbol under cursor",
			callback = vim.lsp.buf.document_highlight,
		})

		api.nvim_create_autocmd("CursorMoved", {
			buffer = bufnr,
			desc = "Resets highlight symbol under cursor",
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- generic lsp setup
-- you can change the individual settings by modifying the table above
for lsp_server, settings in pairs(lsp_servers) do
	config[lsp_server].setup({ on_attach = on_attach, capabilities = capabilities, settings = settings })
end

-- adding autocmd for yamlfmt since it does not have a lsp server
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.{yml,yaml}",
	callback = function(args)
		api.nvim_buf_create_user_command(args.buf, "Format", function()
			vim.lsp.buf.format(nil, nil, { "null-ls" })
		end, {})
	end,
})

-- ChatGPT
chatgpt.setup({
	api_key_cmd = "security find-generic-password -s openai -w",
	chat = {
		welcome_message = "Start Asking....",
		loading_text = "Loading, please wait ...",
		question_sign = "🙋", -- 🙂
		answer_sign = "🤖", -- 🤖
		border_left_sign = "▙",
		border_right_sign = "▜",
		sessions_window = {
			active_sign = "🟩 ",
			inactive_sign = " ⬜️",
			current_line_sign = "►",
		},
	},
	popup_input = {
		prompt = " 🟢 ",
	},
})
