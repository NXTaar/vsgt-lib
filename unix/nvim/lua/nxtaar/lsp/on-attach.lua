local assign_keymaps = require("nxtaar.lsp.keymaps").assign
local attach_formating = require("nxtaar.lsp.formatting").attach
local attach_highlighting = require("nxtaar.lsp.highlighting")

return function(client, bufnr)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	-- Configure key mappings
	assign_keymaps(client, bufnr)

	-- Add formating on save
	attach_formating(client)

	-- Configure highlighting
	attach_highlighting(client, bufnr)

	-- tagfunc
	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
	end
end
