local api = vim.api
local keys = require("utils").keys
local removeElement = require("utils").removeElement

-- adding autocmd for yamlfmt since it does not have a lsp server
-- but null-ls supports formatting yaml file
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.{yml,yaml}",
	callback = function(args)
		api.nvim_buf_create_user_command(args.buf, "Format", function()
			vim.lsp.buf.format(nil, nil, { "null-ls" })
		end, {})
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

	api.nvim_buf_create_user_command(bufnr, "F", function()
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
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			local lsp_servers_to_install = removeElement(keys(lsp_servers), "rust_analyzer") -- use the local rust_analyzer installed by rustup installed of allowing mason to install it.
			require("mason-lspconfig").setup({ ensure_installed = lsp_servers_to_install })
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.prettier_standard,
					null_ls.builtins.formatting.yamlfmt,
				},
			})
		end,
	},
	-- LSP completion
	{
		"hrsh7th/cmp-nvim-lsp",
		lazy = true,
		event = "InsertEnter",
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local config = require("lspconfig")
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			for lsp_server, settings in pairs(lsp_servers) do
				config[lsp_server].setup({ on_attach = on_attach, capabilities = capabilities, settings = settings })
			end
		end,
	},
	{ "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true, event = "InsertEnter" },
	{ "hrsh7th/cmp-buffer",                  lazy = true, event = "InsertEnter" },
	{ "hrsh7th/cmp-path",                    lazy = true, event = "InsertEnter" },
	{
		"hrsh7th/nvim-cmp",
		lazy = true,
		event = "InsertEnter",
		config = function()
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
								for _, win in ipairs(api.nvim_list_wins()) do
									bufs[api.nvim_win_get_buf(win)] = true
								end
								return vim.tbl_keys(bufs)
							end,
						},
					},
				}, { { name = "path", keyword_length = 3, max_item_count = 3 } }),
			})
		end,
	},
}
