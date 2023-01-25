local json_schemas = require('schemastore').json.schemas()
local has_eslint_config = require('nxtaar.lsp.utils').has_eslint_config
local check_for_custom_config = require('nxtaar.lsp.utils').check_for_custom_config

local exports = {}

exports.settings = {
	jsonls = {
		settings = {
			json = {
				schemas = json_schemas,
			},
		},
	},
	cssls = {},
	cssmodules_ls = {},
	html = {},
	eslint = {
		on_attach = function(client, bufnr)
			local path = vim.api.nvim_buf_get_name(bufnr)
			local custom_config = check_for_custom_config(path)

			if custom_config then
				client.config.settings.options = {
					configFile = custom_config,
				}
			end

			client.server_capabilities.documentFormattingProvider = true
			client.server_capabilities.documentRangeFormattingProvider = true
		end,
	},
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
					-- Setup your lua path
					path = vim.split(package.path, ';'),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'packer_plugins' },
					-- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand('$VIMRUNTIME/lua')] = true,
						[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
					},
					-- library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
				completion = { callSnippet = 'Both' },
				telemetry = { enable = false },
			},
		},
	},
	tsserver = {
		on_attach = function(client, bufnr)
			if not has_eslint_config(bufnr) then
				return
			end

			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end,
	},
	yamlls = {
		schemastore = {
			enable = true,
		},
		settings = {
			yaml = {
				hover = true,
				completion = true,
				validate = true,
				schemas = json_schemas,
			},
		},
	},
}

exports.language_servers = vim.tbl_filter(function(server)
	return server ~= 'tsserver'
end, vim.tbl_keys(exports.settings))

return exports
