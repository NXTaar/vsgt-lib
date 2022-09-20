local null_ls = require('null-ls')

return function()
	null_ls.setup({
		sources = {
			require('null-ls').builtins.formatting.stylua,
			null_ls.builtins.formatting.prettier.with({
				filetypes = { 'yaml', 'markdown', 'css', 'graphql' },
			}),
		},
	})
end
