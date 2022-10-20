local cmp = require("cmp")
local luasnip = require("luasnip")
local icons = require("nxtaar.code-completion.icons")

local source = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[Nvim Lua stdlib]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	path = "[Path]",
	npm = "[NPM Registry]",
}

return {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	formatting = {
		fields = { "abbr", "menu", "kind" },
		format = function(entry, vim_item)
			-- Kind icons
			-- vim_item.kind = string.format("%s", icons[vim_item.kind])
			vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = source[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "npm", keyword_length = 4 },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	experimental = {
		ghost_text = true,
		native_menu = false,
	},
}
