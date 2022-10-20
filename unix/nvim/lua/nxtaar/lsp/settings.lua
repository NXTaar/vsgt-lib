local json_schemas = require("schemastore").json.schemas()
local on_attach = require("nxtaar.lsp.on-attach")
local capabilities = require("nxtaar.lsp.capabilities")
local exports = {}

local server_functions = {
    on_attach = on_attach,
    capabilities = capabilities,
}

local settings = {
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
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = vim.split(package.path, ";"),
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
					-- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					-- library = vim.api.nvim_get_runtime_file("", true),
					maxPreload = 2000,
					preloadFileSize = 50000,
				},
				completion = { callSnippet = "Both" },
				telemetry = { enable = false },
			},
		},
	},
	tsserver = { disable_formatting = true },
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

exports.language_servers = vim.tbl_keys(settings)

function exports.get_server_settings(server_name)
	return vim.tbl_deep_extend("force", server_functions, settings[server_name] or {})
end

return exports
