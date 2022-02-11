local cmp = require("cmp")
local cmp_npm = require("cmp-npm")
local luasnip_vscode = require("luasnip/loaders/from_vscode")
local settings = require("code-completion.settings")
local mapping = require("code-completion.keymaps").mapping

settings.mapping = mapping

local exports = {}

function exports.plugin(use)
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lua"
    use {
        'David-Kunz/cmp-npm',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use "hrsh7th/cmp-nvim-lsp"

    -- Snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
end

function exports.init()
    luasnip_vscode.lazy_load()

    cmp_npm.setup({})
    cmp.setup(settings)
end

return exports
