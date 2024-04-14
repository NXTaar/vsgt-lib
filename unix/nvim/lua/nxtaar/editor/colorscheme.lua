local M = {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    opts = {
        bold_keywords = true,
        transparent_bg = true
    }
}

function M.config(_, opts)
    local theme = require('nordic')

    theme.setup(opts)
    theme.load()
    -- nordic.setup({
    --     on_palette = function(palette)
    --         return palette
    --     end,
    --     bold_keywords = true,
    --     -- transparent_bg = true,
    -- })

    -- nordic.load()
    -- vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
end

return M
