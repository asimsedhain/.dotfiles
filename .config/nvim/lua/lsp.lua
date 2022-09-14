local config = require("lspconfig")
local api = vim.api
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	--vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)


	-- user command for formating and code actions
	api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.formatting, {})
	api.nvim_buf_create_user_command(bufnr, "Caction", vim.lsp.buf.code_action, {})


	-- highlighting on cursorhold
	api.nvim_create_autocmd('CursorHold',
		{
			buffer = bufnr,
			desc = 'Highlight symbol under cursor',
			callback = vim.lsp.buf.document_highlight
		})
	api.nvim_create_autocmd('CursorHoldI',
		{
			buffer = bufnr,
			desc = 'Highlight symbol under cursor',
			callback = vim.lsp.buf.document_highlight
		})
	api.nvim_create_autocmd('CursorMoved',
		{
			buffer = bufnr,
			desc = 'Resets highlight symbol under cursor',
			callback = vim.lsp.buf.clear_references
		})
end


-- lua setup
config.sumneko_lua.setup { diagnostics = {
	-- Get the language server to recognize the `vim` global
	globals = { 'vim' }
},
	on_attach = on_attach }

-- generic lsp setup
for _, v in pairs({ 'pyright' }) do
	config[v].setup { on_attach = on_attach }
end
