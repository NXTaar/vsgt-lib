local ts = require("typescript")
local lspconfig = require("lspconfig")
local get_server_settings = require("nxtaar.lsp.settings").get_server_settings

local function on_attach_mixin(settings, handler)
	return vim.tbl_deep_extend("force", settings, {
		on_attach = function(client, bufnr)
			handler(client, bufnr)
			settings.on_attach(client, bufnr)
		end,
	})
end

local custom_handlers = {
	tsserver = function(settings)
		ts.setup({
			disable_commands = false,
			debug = false,
			server = on_attach_mixin(settings, function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				settings.on_attach(client, bufnr)
			end),
		})
	end,
	eslint = function(settings)
		lspconfig.eslint.setup(on_attach_mixin(settings, function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = true
			client.server_capabilities.documentRangeFormattingProvider = true
			
			settings.on_attach(client, bufnr)
		end))
	end,
}

local function attach_custom_handlers(storage)
	for server_name, handler in pairs(custom_handlers) do
		storage[server_name] = function()
			handler(get_server_settings(server_name))
		end
	end

	return storage
end

return attach_custom_handlers
