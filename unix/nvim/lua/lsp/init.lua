local lsp_installer_servers = require('nvim-lsp-installer.servers')
local diagnostic = require('lsp.diagnostic')
local formatting = require('lsp.formatting')
local settings = require('lsp.settings')
local mapping = require('lsp.keymaps').mapping
local utils = require('lsp.utils')
local exports = {}

function exports.plugin(use)
	use('neovim/nvim-lspconfig') -- enable LSP
	use('williamboman/nvim-lsp-installer') -- simple to use language server installer
	use('tamago324/nlsp-settings.nvim') -- language server settings defined in json for
	use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters
	use('MunifTanjim/prettier.nvim')
	use({
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	})
end

local function on_attach(client, bufnr)
	if client.name == 'tsserver' then
		client.resolved_capabilities.document_formatting = false
	end

	utils.assign_keymaps(mapping, bufnr)
	utils.lsp_highlight_document(client)
end

local function assign_icons()
	for _, sign in ipairs(settings.icons) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
	end
end

local function assign_commands()
	for _, command in pairs(settings.commands.cmd) do
		vim.cmd(command)
	end
end

local function init_lsp_servers()
	for _, server_name in pairs(settings.servers) do
		local server_available, server = lsp_installer_servers.get_server(server_name)
		if server_available then
			server:on_ready(function()
				local opts = {
					flags = {
						-- This will be the default in neovim 0.7+
						debounce_text_changes = 150,
					},
					on_attach = on_attach,
					capabilities = utils.capabilities,
				}

				if settings.additional_opts[server_name] then
					opts = vim.tbl_deep_extend('force', settings.additional_opts[server_name], opts)
				end

				server:setup(opts)
			end)

			if not server:is_installed() then
				server:install()
			end
		end
	end
end

function exports.init()
	init_lsp_servers()
	assign_icons()
	diagnostic()
	assign_commands()
	formatting()
end

return exports
