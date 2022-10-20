local has_illuminate_highlighter, illuminate = pcall(require, "illuminate")
local api = vim.api

illuminate.configure({
	delay = 800,
	filetypes_denylist = {
		"alpha",
		"fugitive",
		"NvimTree",
	},
	modes_allowlist = { "n" },
})

vim.cmd([[hi def IlluminatedWordText cterm=reverse guifg=#d8dee9 guibg=#3b4252]])
vim.cmd([[hi def IlluminatedWordRead cterm=reverse guifg=#d8dee9 guibg=#3b4252]])
vim.cmd([[hi def IlluminatedWordWrite cterm=reverse guifg=#d8dee9 guibg=#3b4252]])

return function(client, bufnr)
	if not client.server_capabilities.documentHighlightProvider or has_illuminate_highlighter then
		return
	end

	local lsp_highlight_grp = api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

	api.nvim_create_autocmd("CursorHold", {
		callback = function()
			vim.schedule(vim.lsp.buf.document_highlight)
		end,
		group = lsp_highlight_grp,
		buffer = bufnr,
	})
	
	api.nvim_create_autocmd("CursorMoved", {
		callback = function()
			vim.schedule(vim.lsp.buf.clear_references)
		end,
		group = lsp_highlight_grp,
		buffer = bufnr,
	})
end
