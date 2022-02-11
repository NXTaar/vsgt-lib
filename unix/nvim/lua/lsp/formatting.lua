local null_ls = require("null-ls")
local prettier = require("prettier")

local prettier_opts = require("lsp.settings.prettierls")

return function()
	null_ls.setup({
		sources = {
			require("null-ls").builtins.formatting.stylua,
		},
	})
	prettier.setup(prettier_opts)
end
