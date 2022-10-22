local icons = {
	{ name = 'DiagnosticSignError', text = '' },
	{ name = 'DiagnosticSignWarn', text = '' },
	{ name = 'DiagnosticSignHint', text = '' },
	{ name = 'DiagnosticSignInfo', text = '' },
}

local float_config = {
	focusable = true,
	style = 'minimal',
	border = 'rounded',
}

local diagnostic_config = {
	-- virtual_text = false,
	-- virtual_text = { spacing = 4, prefix = "●" },
	virtual_text = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		active = icons,
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		focusable = true,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}

for _, icon in ipairs(icons) do
	vim.fn.sign_define(icon.name, { texthl = icon.name, text = icon.text, numhl = icon.name })
end

-- Diagnostic configuration
vim.diagnostic.config(diagnostic_config)

-- Hover configuration
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, float_config)

-- Signature help configuration
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, float_config)
