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
	lua_ls = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = 'LuaJIT',
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { 'vim' },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file('', true),
					checkThirdParty = false,
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
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
