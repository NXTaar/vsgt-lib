local cmp = require('cmp')
local cmp_npm = require('cmp-npm')
local luasnip_vscode = require('luasnip/loaders/from_vscode')
local settings = require('nxtaar.code-completion.settings')
local mapping = require('nxtaar.code-completion.keymaps').mapping

settings.mapping = mapping

luasnip_vscode.lazy_load()

cmp_npm.setup({})
cmp.setup(settings)
