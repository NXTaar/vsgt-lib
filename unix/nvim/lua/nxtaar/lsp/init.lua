local mason = require('mason')
local lspconfig = require('lspconfig')
local mason_lsp_config = require('mason-lspconfig')
local mason_tool_installer = require('mason-tool-installer')
local get_server_settings = require('nxtaar.lsp.settings').get_server_settings
local language_servers = require('nxtaar.lsp.settings').language_servers
local attach_custom_handlers = require('nxtaar.lsp.custom-handlers')

require('nxtaar.lsp.diagnostics')

mason.setup({
	ui = {
		icons = {
			package_installed = '✓',
		},
	},
})

mason_lsp_config.setup({
	ensure_installed = language_servers,
})

mason_tool_installer.setup({
	ensure_installed = { 'stylua', 'prettierd' },
	auto_update = false,
	run_on_start = true,
})

mason_lsp_config.setup_handlers(attach_custom_handlers({
	function(server_name)
		lspconfig[server_name].setup(get_server_settings(server_name))
	end,
}))
