local M = {
    'stevearc/oil.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    }
}

function M.config()
    local oil = require('oil')

    oil.setup({
        float = {
            -- Padding around the floating window
            max_width = 80,
            max_height = 20,
            border = 'rounded',
            win_options = {
                winblend = 10,
            },
        },
        view_options = {
            show_hidden = true
        }
    })

    register_keymap_action('oil.open', function()
        vim.cmd('Oil --float')
    end)
end

return M

