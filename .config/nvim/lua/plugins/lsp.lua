local api = vim.api
local keys = require("utils").keys
local map = require("utils").map
local remove_element = require("utils").remove_element

--- @param lsp_name string
--- @return function
local format_function_fac = function(lsp_name)
	local func = function(_client)
		vim.lsp.buf.format({ async = false, name = lsp_name })
	end
	return func
end

-- adding autocmd for yamlfmt since it does not have a lsp server
-- but null-ls supports formatting yaml file
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.{yml,yaml}",
	callback = function(args)
		api.nvim_buf_create_user_command(args.buf, "Format", format_function_fac("null-ls"), {})
	end,
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
		border = 'single',
	},
}

-- LSP servers and settings
local lsp_servers = {
	bashls = {},
	terraformls = {},
	pyright = {},
	ruff = {},
	gopls = {},
	html = {},
	jsonls = {},
	ts_ls = {},
	eslint = {},
	marksman = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				-- enable clippy on save
				check = {
					command = "clippy",
				},
				diagnostics = {
					enable = true,
				},
			},
		}
	},
	svelte = {},
	cssls = {
		settings = {
			css = {
				lint = {
					unknownAtRules = "ignore",
				},
			},
		}
	},
	tailwindcss = {},
	clangd = {},
	lua_ls = {
		settings = {
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
				format = {
					enable = true,
				}
			},
		},

	}
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	map("n", "<Space>d", vim.diagnostic.open_float,
		{ buffer = bufnr, desc = "<Space>-d to open diagnostic floating window" })
	map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "gD: [g]o to [D]eclaration" })
	map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "gd: [g]o to [d]efinition" })
	map("n", "gy", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "gy: [g]o to t[y]pe definition" })
	map("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "gi: [g]o to [i]mplementation" })
	map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "gr: [g]o to [r]eferences" })
	map("n", "<F2>", vim.lsp.buf.rename, { buffer = bufnr, desc = "<F2> LSP rename" })
	map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "K: show buf hover information" })

	if client.supports_method("textDocument/formatting", { bufnr = bufnr }) then
		api.nvim_buf_create_user_command(bufnr, "Format", format_function_fac(client.name), {})
		api.nvim_buf_create_user_command(bufnr, "F", format_function_fac(client.name), {})
	end



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

-- return exports the whole module
-- lazy will stitch all the everything together
-- https://github.com/folke/lazy.nvim?tab=readme-ov-file#-structuring-your-plugins
return {

	-- LSP manager
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup(mason_settings)
		end,
		build = ":MasonUpdate",
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local lsp_servers_to_install = remove_element(keys(lsp_servers), "rust_analyzer") -- use the local rust_analyzer installed by rustup installed of allowing mason to install it.
			require("mason-lspconfig").setup({ ensure_installed = lsp_servers_to_install })
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.prettier_standard,
					null_ls.builtins.formatting.yamlfmt,
				},
			})
		end,
	},
	-- LSP completion
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local config = require("lspconfig")

			--local capabilities =
			local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())

			for lsp_server, cfg in pairs(lsp_servers) do
				config[lsp_server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = cfg
						.settings,
					cmd = cfg.cmd
				})
			end
		end,
	},
	{
		'saghen/blink.cmp',
		-- use a release tag to download pre-built binaries
		version = '1.*',
		lazy = true,
		event = "InsertEnter",
		opts = {
			keymap = {
				preset = 'none',
				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<C-n>'] = { 'select_next' },
				['<C-p>'] = { 'select_prev' },
			},

			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				menu = {
					draw = {
						padding = 1,
						gap = 1,
						columns = { { "label", "label_description" }, { "kind" } }
					}
				}
			},

			sources = {
				default = { 'lsp', 'path', 'buffer' },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	}
}
