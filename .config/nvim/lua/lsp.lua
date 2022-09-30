local config = require("lspconfig")
local api = vim.api

local lsp_servers =
	{ "pyright", "gopls", "html", "jsonls", "tsserver", "remark_ls", "rust_analyzer", "svelte", "cssls", "clangd" }

require("mason-lspconfig").setup({ ensure_installed = lsp_servers })

-- nvim-cmp completion engine
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
cmp.setup({
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
		{ name = "nvim_lsp" },
	}, {
		{ name = "buffer", keyword_length = 2 },
	}, { { name = "path", keyword_length = 3 } }),
})

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, bufopts)
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
		vim.lsp.buf.formatting_seq_sync(nil, nil, { "null-ls" })
	end, {})
	api.nvim_buf_create_user_command(bufnr, "Caction", vim.lsp.buf.code_action, {})

	-- highlighting on cursorhold
	if client.resolved_capabilities.document_highlight then
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

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- lua lsp setup
config.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
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
		},
	},
})

-- generic lsp setup
for _, v in pairs(lsp_servers) do
	config[v].setup({ on_attach = on_attach, capabilities = capabilities })
end
