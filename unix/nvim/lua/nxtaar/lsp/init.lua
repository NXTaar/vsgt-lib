local lsp = require('lsp-zero')
local null_ls = require('null-ls')
local typescript = require('typescript')

local attach_formating = require('lsp-format').on_attach
local settings = require('nxtaar.lsp.settings').settings
local language_servers = require('nxtaar.lsp.settings').language_servers
local assign_keymaps = require('nxtaar.lsp.keymaps').assign_keymaps

local null_ls_formatting = null_ls.builtins.formatting
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

lsp.preset('recommended')

for _, server in ipairs(language_servers) do
	if vim.tbl_count(settings[server]) > 0 then
		lsp.configure(server, settings[server])
	end
end

lsp.ensure_installed(language_servers)

lsp.on_attach(function(client, buffer_number)
	-- Enable completion triggered by <C-X><C-O>
	-- See `:help omnifunc` and `:help ins-completion` for more information.
	vim.api.nvim_buf_set_option(buffer_number, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Use LSP as the handler for formatexpr.
	-- See `:help formatexpr` for more information.
	vim.api.nvim_buf_set_option(buffer_number, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

	assign_keymaps(client, buffer_number)

	attach_formating(client)

	if client.server_capabilities.definitionProvider then
		vim.api.nvim_buf_set_option(buffer_number, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
	end
end)

lsp.setup()

null_ls.setup({
	sources = {
		null_ls_formatting.stylua,
		null_ls_formatting.prettierd.with({
			filetypes = { 'yaml', 'markdown', 'css', 'graphql' },
		}),
	},
	on_attach = function(client, bufnr)
		if client.supports_method('textDocument/formatting') then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

typescript.setup({
	server = settings.tsserver,
})
