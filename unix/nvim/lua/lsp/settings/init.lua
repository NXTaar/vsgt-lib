local exports = {}

exports.servers = { 'tsserver', 'yamlls', 'sumneko_lua', 'jsonls', 'eslint', 'cssls', 'cssmodules_ls', 'html' }

exports.additional_opts = {
	jsonls = require('lsp.settings.jsonls'),
	sumneko_lua = require('lsp.settings.sumneko_lua'),
}

exports.commands = {
	cmd = {
		[[ command! Format execute 'lua vim.lsp.buf.formatting()' ]],
		[[
            augroup fix_eslint_onsave
                autocmd! *
                autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx EslintFixAll
            augroup END
        ]],
	},
}

exports.icons = {
	{ name = 'DiagnosticSignError', text = '' },
	{ name = 'DiagnosticSignWarn', text = '' },
	{ name = 'DiagnosticSignHint', text = '' },
	{ name = 'DiagnosticSignInfo', text = '' },
}

exports.diagnostic_opts = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = exports.icons,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = 'minimal',
		border = 'rounded',
		source = 'always',
		header = '',
		prefix = '',
	},
}

return exports
