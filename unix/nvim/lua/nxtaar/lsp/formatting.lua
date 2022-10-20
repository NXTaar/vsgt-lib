local lsp_format = require("lsp-format")
local null_ls = require("null-ls")
local null_ls_formatting = null_ls.builtins.formatting

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

lsp_format.setup()

null_ls.setup({
	sources = {
		null_ls_formatting.stylua,
		null_ls_formatting.prettierd.with({
			filetypes = { "yaml", "markdown", "css", "graphql" },
		}),
	},
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
